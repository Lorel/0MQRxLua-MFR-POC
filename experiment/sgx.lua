local log = require 'log'

log.level = os.getenv('LOG_LEVEL') or 'info'
log.outfile = os.getenv('LOG_DIR') and os.getenv('LOG_DIR') .. os.getenv('HOSTNAME')


-- define SGX globally
_G.SGX = {
  cjson = cjson or require 'cjson',
  encrypt = sgxencrypt or function(x) return x end,
  process = sgxprocess or function(func, params)
    log.debug('Call mocked sgxprocess with:', func, params)
    load('SGX.func = ' .. func)()
    return tostring(SGX.func(params)) -- ensure that sgxprocess returns a string value
  end,
  decrypt = sgxdecrypt or function(x) return x end,
}

-- utils
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

local dump_file = "func_bytecode.luac"

local function dump_to_file (func)
  file = io.open(dump_file, 'w')
  io.output(file)
  io.write(string.dump(func))
  io.close(file)
end

local function decompile (func)
  dump_to_file(func)
  local source_code = os.capture('luadec -q ' .. dump_file)
  os.execute('rm ' .. dump_file)
  return source_code
end
-- utils END

function SGX:function_wrapper (func)
  local prefix = 'function(params) func = '
  local include_cjson = ' if not cjson then cjson = SGX.cjson end '  -- use globally defined cjson for non-SGX execution
  local suffix = include_cjson .. ' return cjson.encode(func(table.unpack(cjson.decode(params)))) end'
  local wrapped_func = prefix .. func .. suffix
  log.debug('SGX:function_wrapper wrapped_func:', wrapped_func)
  return wrapped_func
end

function SGX:params_wrapper (...)
  local params = self.cjson.encode({...})
  log.debug('SGX:params_wrapper params:', params)
  return params
end

function SGX:exec (func, ...)
  log.debug('SGX:exec', func, ...)
  return self.cjson.decode(self.decrypt(self.process(self.encrypt(self:function_wrapper(func)), self.encrypt(self:params_wrapper(...)))))
end

function SGX:exec_func (func, ...)
  log.debug('SGX:exec_func', func, ...)
  return self:exec(decompile(func), ...)
end


return SGX
