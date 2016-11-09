local ZmqRx = require 'zmq-rx'

local file = 'data/sample.csv'

local to_socket = os.getenv('TO') or 'tcp://localhost:5555'

ZmqRx.Observable.fromFileByLine(file)
  :subscribeToSocket(to_socket) -- 'tcp://localhost:5555'
