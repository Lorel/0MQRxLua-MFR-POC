--Some statistical operations in tables of numbers

function mean( t )
  local sum = 0
  local count= 0
  for k,v in pairs(t) do
    --if type(v) == 'number' then
      sum = sum + v
      count = count + 1
   -- end
  end
  return (sum / count)
end

-- Get the standard deviation of a table
function standardDeviation( t )
  local m
  local vm
  local sum = 0
  local count = 0
  local result

  m = mean( t )

  for k,v in pairs(t) do
   -- if type(v) == 'number' then
      vm = v - m
      sum = sum + (vm * vm)
      count = count + 1
   -- end
  end

  result = math.sqrt(sum / (count-1))

  return result,m
end

function round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end
function percentiles(requestedPercentiles , values)	
	local percs={}	
	local tempValues={}
	for i=1,#values do
		tempValues[i]=values[i]
	end
	table.sort(tempValues)
	for _,reqPerc in pairs(requestedPercentiles) do
		
		local p = tempValues[ round( reqPerc / 100 * #values+0.5) ]
		--print("INPUT VALUES:",table.concat(tempValues," "), "%th:", reqPerc, "ris:", p)
		table.insert(percs, p)
	end
	--table.insert(percs,tempValues[1])
	--table.insert(percs,tempValues[#tempValues])		
	return percs
end


--filename=arg[1]
--
--local lines = {}
---- read the lines in table 'lines'
--if filename~=nil then
--	for line in io.lines(filename) do
--		table.insert(lines,tonumber(line))
--	end
--else
--	for line in io.lines() do
--		table.insert(lines,tonumber(line))
--	end
--end

local l_c=1
for l in io.lines() do
	--print(l)
	--read all numbers in this line
	local t = {}
	for num in string.gmatch(l, "(%d+)") do t[#t+1]=tonumber(num) end
	print(l_c, table.concat(percentiles({1,25,50,75,99},t), " ")) --table.concat(t," ")
	l_c=l_c+1
end