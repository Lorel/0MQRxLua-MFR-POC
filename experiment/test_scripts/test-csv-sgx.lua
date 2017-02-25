local SGX = require "sgx"

local map_csv = function(s)
  if not s then return nil end

  local csv = require 'csv'
  local array = csv.parse(s)
  return array
end

local s = "Year,Month,DayofMonth,DayOfWeek,DepTime,CRSDepTime,ArrTime,CRSArrTime,UniqueCarrier,FlightNum,TailNum,ActualElapsedTime,CRSElapsedTime,AirTime,ArrDelay,DepDelay,Origin,Dest,Distance,TaxiIn,TaxiOut,Cancelled,CancellationCode,Diverted,CarrierDelay,WeatherDelay,NASDelay,SecurityDelay,LateAircraftDelay"

print(SGX:exec_func(map_csv, s)[1])
