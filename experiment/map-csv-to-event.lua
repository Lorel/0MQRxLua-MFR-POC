local ZmqRx = require 'zmq-rx'
local csv = require 'csv'

local from_socket = os.getenv('FROM') or 'tcp://localhost:5555'
local to_socket = os.getenv('TO') or 'tcp://localhost:5556'


ZmqRx.Subject.fromZmqSocket(from_socket) -- 'tcp://localhost:5555'
  :map(
    function(value)
      -- print('process value', value)
      local success, array = pcall(csv.parse, value)

      if success then
        local event = {}
        event.uniquecarrier = array[9]
        event.arrdelay = array[15]
        return event
      end

      return {}
    end
  )
  :subscribeToSocket(to_socket) -- 'tcp://localhost:5556'
