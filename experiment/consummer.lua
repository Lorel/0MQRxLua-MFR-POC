local ZmqRx = require 'zmq-rx'

local from_socket = os.getenv('FROM') or 'tcp://*:5555'

ZmqRx.openController()

ZmqRx.Observable.fromZmqSocket(from_socket) -- 'tcp://*:5555'
  :subscribe(
    function(results)
    end,
    function(error)
      print(error)
    end,
    function()
      ZmqRx.sendZmqCompleted()
      print('completed!')
    end
  )
