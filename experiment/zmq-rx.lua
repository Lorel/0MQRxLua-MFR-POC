-- ØMQ-RxLua v0.0.0

local Rx = require 'rx'
local zmq = require 'lzmq'
local zloop = require 'lzmq.loop'
local ztimer = require 'lzmq.timer'
local json = require 'cjson'
local log = require 'log'

log.level = os.getenv('LOG_LEVEL') or 'info'

local controlConnectSocket = os.getenv('TO_CONTROLLER') or 'tcp://localhost:5554'
local controlBindSocket = os.getenv('CONTROLLER') or 'tcp://*:5554'

local doneToken = '!STOP!'
local killSig = 'KILL'

local sendCounter = 0
local receiveCounter = 0

function identity()
  math.randomseed(os.time() + math.random())
  return string.format('%04X-%04X', math.random (0x10000), math.random (0x10000))
end

function Rx.Observable.fromZmqSocket(socket)
  return Rx.Observable.create(function(observer)
    local loop = zloop.new()
    local receiving = true

    --  Socket to receive messages on
    local receiver, err  = loop:create_socket{ zmq.REQ,
      linger = 0, sndtimeo = 100, rcvtimeo = 100;
      connect = socket; identity = identity();
    }

    log.info('Create Rx.Observable.fromZmqSocket from socket', socket)

    loop:add_socket(receiver, function(sok)
      local address = sok:recv()
      log.trace('Sender address', address)
      local empty = sok:recv()
      assert (#empty == 0)
      local msg = assert(sok:recv())
      receiveCounter = receiveCounter + 1
      log.trace('receive msg', receiveCounter, msg)

      --  Do the work
      if msg == doneToken then
        log.info('Received DONE token')
        loop:interrupt()
      else
        local event = json.decode(msg)
        observer:onNext(event)

        sok:send(address, zmq.SNDMORE)
        sok:send('', zmq.SNDMORE)
        assert(sok:send('OK'))
        log.trace('heartbeat sent to router')
      end
    end)

    --  Socket to receive controls on
    local ctx = zmq.context()
    local controller = ctx:socket(zmq.SUB)
    assert(controller:set_subscribe(killSig))
    controller:connect(controlConnectSocket)

    loop:add_socket(controller, zmq.POLLIN, function()
      log.info('add controller subscription')
      local message = controller:recv_new_msg()
      log.debug('controller msg', message)
      log.info('stop loop')
      loop:interrupt()
    end)

    --  ping router
    log.info('Send READY to router')
    receiver:send('READY')

    loop:start()

    --  Finished
    observer:onCompleted()
  end)
end

function Rx.Observable:subscribeToSocket(socket)
  log.info('Create Rx.Observable:subscribeToSocket to socket', socket)
  local ctx = zmq.context()

  --  Socket to receive messages on
  local sender = ctx:socket(zmq.REQ, { sndtimeo = 1000, rcvtimeo = 1000; identity = identity(); })

  local ok, err = sender:connect(socket)
  log.debug('Init socket connection', ok, err)

  return self:subscribe(
    function(event)
      local msg = json.encode(event)

      local ok, err = sender:send(msg)
      log.debug('Send msg', ok, err)
      sendCounter = sendCounter + 1
      log.trace('send msg', sendCounter, msg)

      local reply = sender:recv()
      log.debug('Reply:', reply)
    end,
    function(error)
      log.error('Error:', error)
    end,
    function()
      log.info('Transmission done!')
      sender:send(doneToken)

      local controller = ctx:socket(zmq.SUB)
      assert(controller:set_subscribe(killSig))
      controller:connect(controlConnectSocket)

      local message = controller:recv_new_msg()
      log.debug('controller msg', message)

      sender:close()
      ctx:term()
    end
  )
end


function Rx.sendZmqCompleted()
  local ctx = zmq.context()

  --  Socket for worker control
  local controller = ctx:socket(zmq.PUB)
  log.debug('controller', controller)
  controller:bind(controlBindSocket)
  log.debug('controller binded')

  log.debug('Rx.sendZmqCompleted()')

  -- Wait for every subscribers to connect
  ztimer.sleep(500)

  --  Send kill signal to workers
  controller:send(killSig)
  log.debug('first KILL sent')

  -- Wait for other subscribers to connect
  ztimer.sleep(2000)

  --  Send kill signal to workers
  controller:send(killSig)
  log.debug('second KILL sent')

  controller:close()
  ctx:term()
end


return Rx
