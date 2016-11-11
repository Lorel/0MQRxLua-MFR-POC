local ZmqRx = require 'zmq-rx'

local from_socket = os.getenv('FROM') or 'tcp://*:5558'

ZmqRx.Observable.fromZmqSocket(from_socket) -- 'tcp://*:5558'
  :subscribe(
    function(results)
      for k,v in pairs(results) do
        print('Delays for carrier ' .. k .. ' -> ' .. (v.count == 0 and 0 or (v.total / v.count)) .. ' average mins - ' .. v.count .. " delayed flights")
      end
    end,
    function(error)
      print(error)
    end,
    function()
      ZmqRx.sendZmqCompleted()
      print('completed!')
    end
  )
