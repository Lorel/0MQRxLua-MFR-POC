local zmq = require 'lzmq'
local zpoller = require 'lzmq.poller'
local ztimer = require 'lzmq.timer'
local log = require 'log'

log.level = os.getenv('LOG_LEVEL') or 'info'
log.outfile = os.getenv('LOG_DIR') and os.getenv('LOG_DIR') .. os.getenv('HOSTNAME')

local fromSocket = os.getenv('FROM') or 'tcp://*:5555'
local toSocket = os.getenv('TO') or 'tcp://*:5556'
local controlConnectSocket = os.getenv('TO_CONTROLLER') or 'tcp://localhost:5554'

local tremove = table.remove

local context = zmq.init(1)
local frontend = context:socket(zmq.ROUTER)
local backend = context:socket(zmq.ROUTER)
local controller = context:socket{ zmq.SUB,
    subscribe = { 'KILL' };
    connect = controlConnectSocket;
  }

local sendCounter = 0
local receiveCounter = 0

log.info('CREATING ROUTER FROM', fromSocket, 'TO', toSocket)


local doneToken = '!STOP!'

frontend:bind(fromSocket)
backend:bind(toSocket)

--  Logic of LRU loop
--  - Poll backend always, frontend only if 1+ worker ready
--  - If worker replies, queue worker as ready and forward reply
--    to client if necessary
--  - If client requests, pop next worker and send request to it

--  Queue of available workers
local worker_queue = {}

--  Clients inventory
local clients_inventory = { count = 0 }
local workers_inventory = { count = 0 }

local is_accepting = false
-- local max_requests = #clients

local poller = zpoller.new(3)

local function frontend_cb()
    --  Now get next client request, route to LRU worker
    --  Client request is [address][empty][request]
    local client_addr = frontend:recv()
    log.trace('frontend client_addr:', client_addr)
    local empty = frontend:recv()
    assert(#empty == 0)

    --  Inventory client
    if not clients_inventory[client_addr] then
      log.info('Inventory client:', client_addr)
      clients_inventory[client_addr] = true
      clients_inventory["count"] = clients_inventory["count"] + 1
      log.info('Client inventory count:', clients_inventory["count"])
    end

    local request = frontend:recv()
    receiveCounter = receiveCounter + 1
    log.trace('frontend request: ', request, receiveCounter)

    if (request == doneToken) then
      --  Inventory client
      log.info('Client transmission done:', client_addr)
      clients_inventory[client_addr] = nil
      clients_inventory["count"] = clients_inventory["count"] - 1
      log.info('Client inventory count:', clients_inventory["count"])

      if (clients_inventory["count"] == 0) then
        --  Send doneToken to all workers
        while (#worker_queue ~= 0) do
          -- Dequeue a worker from the queue.
          local worker_addr = tremove(worker_queue, 1)

          backend:send(worker_addr, zmq.SNDMORE)
          backend:send('', zmq.SNDMORE)
          backend:send('ROUTER', zmq.SNDMORE)
          backend:send('', zmq.SNDMORE)
          backend:send(doneToken)

          sendCounter = sendCounter + 1
          log.debug('Sent', request, sendCounter)

          --  Inventory worker
          log.info('Worker transmission done:', worker_addr)
          workers_inventory[worker_addr] = nil
          workers_inventory["count"] = workers_inventory["count"] - 1
          log.info('Worker inventory count:', workers_inventory["count"])
        end
      end
    else
      -- Dequeue a worker from the queue.
      local worker = tremove(worker_queue, 1)

      backend:send(worker, zmq.SNDMORE)
      backend:send('', zmq.SNDMORE)
      backend:send(client_addr, zmq.SNDMORE)
      backend:send('', zmq.SNDMORE)
      backend:send(request)

      sendCounter = sendCounter + 1
      log.trace('Sent', request, sendCounter)
    end

    if (#worker_queue == 0) then
        -- stop accepting work from clients, when no workers are available.
        poller:remove(frontend)
        is_accepting = false
    end
end

log.debug('add backend')
poller:add(backend, zmq.POLLIN, function()
    --  Queue worker address for LRU routing
    local worker_addr = backend:recv()
    worker_queue[#worker_queue + 1] = worker_addr
    log.trace('received worker address', worker_addr)

    --  Inventory worker
    if not workers_inventory[worker_addr] then
      log.info('Inventory worker:', worker_addr)
      workers_inventory[worker_addr] = true
      workers_inventory["count"] = workers_inventory["count"] + 1
      log.info('Worker inventory count:', workers_inventory["count"])
    end

    -- start accepting client requests, if we are not already doing so.
    if not is_accepting then
        is_accepting = true
        poller:add(frontend, zmq.POLLIN, frontend_cb)
    end

    --  Second frame is empty
    local empty = backend:recv()
    assert(#empty == 0)

    --  Third frame is READY or else a client reply address
    local client_addr = backend:recv()
    log.trace('backend client_addr:', client_addr)

    --  If client reply, send rest back to frontend
    if (client_addr ~= 'READY') then
      empty = backend:recv()
      assert (#empty == 0)

      local reply = backend:recv()
      log.trace('backend reply:', reply)
      frontend:send(client_addr, zmq.SNDMORE)
      frontend:send("", zmq.SNDMORE)
      frontend:send(reply)
    end
end)

-- poller:add(controller, zmq.POLLIN, function()
--   log.info('add controller subscription')
--   local message = controller:recv_new_msg()
--   log.debug('controller msg', message)
--   log.info('stop poller')
--   poller:stop()
-- end)

-- start poller's event loop
log.info('start poller')
poller:start()


frontend:close()
backend:close()
context:term()
