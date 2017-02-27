local Rx = require 'zmq-rx'
local SGX = require 'sgx'
local log = require 'log'

log.level = os.getenv('LOG_LEVEL') or 'info'
log.outfile = os.getenv('LOG_DIR') and os.getenv('LOG_DIR') .. os.getenv('HOSTNAME')

local dump_file = "func_bytecode.luac"

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

Rx.util.dump_to_file = function (func)
  file = io.open(dump_file, 'w')
  io.output(file)
  io.write(string.dump(func))
  io.close(file)
end

Rx.util.decompile = function (func)
  Rx.util.dump_to_file(func)
  local source_code = os.capture('luadec -q ' .. dump_file)
  os.execute('rm ' .. dump_file)
  return source_code
end

function Rx.Observable:mapSGX(callback)
  log.info('Rx.Observable:mapSGX', callback)
  return Rx.Observable.create(function(observer)
    callback = callback or Rx.util.identity
    local callback_string = Rx.util.decompile(callback)
    log.info('Rx.Observable.create', callback_string)

    local function onNext(...)
      return Rx.util.tryWithObserver(observer, function(...)
        return observer:onNext(SGX:exec(callback_string, ...))
      end, ...)
    end

    local function onError(e)
      return observer:onError(e)
    end

    local function onCompleted()
      return observer:onCompleted()
    end

    return self:subscribe(onNext, onError, onCompleted)
  end)
end

return Rx
