local zmq = require 'lzmq'
local zpoller = require 'lzmq.poller'
local log = require 'log'

log.level = os.getenv('LOG_LEVEL') or 'info'
log.outfile = os.getenv('LOG_DIR') and os.getenv('LOG_DIR') .. os.getenv('HOSTNAME')

local fromSocket = os.getenv('FROM') or 'tcp://*:5555'
local toSocket = os.getenv('TO') or 'tcp://*:5556'
local controlConnectSocket = os.getenv('TO_CONTROLLER') or 'tcp://localhost:5554'

local tremove = table.remove

local context = zmq.init(1)
local frontend = context:socket(zmq.PULL)
local backend = context:socket(zmq.PUSH)
local controller = context:socket{ zmq.SUB,
    subscribe = { 'KILL' };
    connect = controlConnectSocket;
  }

local sendCounter = 0
local receiveCounter = 0

log.info('CREATING ROUTER FROM', fromSocket, 'TO', toSocket)


local startToken = '!START!'
local doneToken = '!STOP!'

frontend:bind(fromSocket)
backend:bind(toSocket)

--  Clients inventory
local clients_counter = 0
local clients_inventory = { count = 0 }

local poller = zpoller.new(2)

poller:add(frontend, zmq.POLLIN, function ()
  local start_time = os.time()

  local msg = frontend:recv()
  receiveCounter = receiveCounter + 1
  log.trace('frontend received msg: ', msg, receiveCounter)

  if msg == startToken then
    clients_counter = clients_counter + 1
    log.debug('Received startToken, clients_counter:', clients_counter)
  elseif msg == doneToken then
    clients_counter = clients_counter - 1
    log.debug('Received doneToken, clients_counter:', clients_counter)
  else
    backend:send(msg)
    sendCounter = sendCounter + 1
    log.trace('Sent to backend', sendCounter, 'time (s)', os.time() - start_time)
  end

  if (clients_counter == 0) then
    log.info('All clients have sent doneToken, sendCounter:', sendCounter)

    log.info('add controller subscription')
    poller:add(controller, zmq.POLLIN, function()
      local message = controller:recv_new_msg()
      log.debug('controller msg', message)
      log.info('stop poller')
      poller:stop()
    end)

    while true do
      backend:send(doneToken)
    end
  end
end)


-- start poller's event loop
log.info('start poller')
poller:start()

-- close everything
frontend:close()
backend:close()
controller:close()
context:term()
