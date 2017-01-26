-- http://zguide.zeromq.org/lua:msgqueue
-- http://zguide.zeromq.org/c:msgqueue

local zmq = require 'lzmq'
local log = require 'log'

log.level = os.getenv('LOG_LEVEL') or 'info'
log.outfile = os.getenv('LOG_DIR') and os.getenv('LOG_DIR') .. os.getenv('HOSTNAME')

log.info('PIPELINE START')

local fromSocket = os.getenv('FROM') or 'tcp://*:5555'
local toSocket = os.getenv('TO') or 'tcp://*:5556'

local context = zmq.init(1)

--  Socket facing clients
local frontend = context:socket(zmq.PULL)
frontend:bind(fromSocket)

--  Socket facing services
local backend = context:socket(zmq.PUSH)
backend:bind(toSocket)

--  Start built-in device
log.info('CREATING PIPELINE FROM', fromSocket, 'TO', toSocket)
zmq.device(zmq.QUEUE, frontend, backend)

--  We never get here…
frontend:close()
backend:close()
context:term()

log.info('PIPELINE OVER')
