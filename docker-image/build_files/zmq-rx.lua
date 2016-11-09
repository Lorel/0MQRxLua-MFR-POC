-- ØMQ-RxLua v0.0.0

local Rx = require 'rx'
local zmq = require 'lzmq'
local zloop = require 'lzmq.loop'
local ztimer = require 'lzmq.timer'
local json = require 'cjson'

local controlConnectSocket = os.getenv('TO_CONTROLLER') or 'tcp://localhost:5554'
local controlBindSocket = os.getenv('CONTROLLER') or 'tcp://*:5554'

local doneToken = '!STOP!'
local killSig = 'KILL'

local sendCounter = 0
local receiveCounter = 0

function Rx.Observable.fromZmqSocket(socket)
  return Rx.Observable.create(function(observer)
    local loop = zloop.new()
    local receiving = true

    --  Socket to receive messages on
    local receiver, err  = loop:create_socket{zmq.PULL,
      linger = 0, sndtimeo = 100, rcvtimeo = 100;
      bind = {
        socket;
      }
    }

    print('Create Rx.Observable.fromZmqSocket from socket ' .. socket)

    loop:add_socket(receiver, function(sok)
      local msg = assert(sok:recv())
      receiveCounter = receiveCounter + 1

      --  Do the work
      print('receive msg', receiveCounter)
      if msg == doneToken then
        print('Received DONE token')
        loop:interrupt()
      else
        local event = json.decode(msg)
        observer:onNext(event)
      end
    end)

    loop:start()

    --  Finished
    observer:onCompleted()
  end)
end

function Rx.Observable:subscribeToSocket(socket)
  print('Create Rx.Observable:subscribeToSocket to socket ' .. socket)
  local ctx = zmq.context()

  --  Socket to receive messages on
  local sender = ctx:socket(zmq.PUSH)
  sender:connect(socket)

  return self:subscribe(
    function(event)
      local msg = json.encode(event)
      sendCounter = sendCounter + 1
      print('send msg', sendCounter)

    	sender:send(msg)
    end,
    function(error)
      print('Error: ' .. error)
    end,
    function()
      print('Transmission done!')
      sender:send(doneToken)

      local controller = ctx:socket(zmq.SUB)
      assert(controller:set_subscribe(killSig))
      controller:connect(controlConnectSocket)

      local message = controller:recv_new_msg()
      print("controller msg", message)

      sender:close()
      ctx:term()
    end
  )
end

function Rx.openController()
  print('Rx.openController()')

end

function Rx.sendZmqCompleted()
  local ctx = zmq.context()

  --  Socket for worker control
  local controller = ctx:socket(zmq.PUB)
  print('controller', controller)
  controller:bind(controlBindSocket)
  print('controller binded')

  print('Rx.sendZmqCompleted()')

  -- Wait for every subscribers to connect
  ztimer.sleep(500)

  --  Send kill signal to workers
  controller:send(killSig)
  print('KILL sent')

  controller:close()
  ctx:term()
end


return Rx
