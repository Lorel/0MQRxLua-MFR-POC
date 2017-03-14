--Some statistical operations in tables of numbers

function sum( t )
  local sum = 0
  for k,v in pairs(t) do
    --if type(v) == 'number' then
      sum = sum + v
   -- end
  end
  return sum
end


local l_c=1
for l in io.lines() do
	--print(l)
	--read all numbers in this line
	local t = {}
	for num in string.gmatch(l, "(%d+)") do t[#t+1]=tonumber(num) end
	print(l_c, sum(t)) --table.concat(t," ")
	l_c=l_c+1
end
