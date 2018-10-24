require"pumpmodule"
require"temperture_humidity"

gbtp = 0
gbrh = 0
  -- body

function  mainserver()
  ret,tpin,rhin = temperture_humidity.ReadTemperHumidity()
  if(ret == 0) then
    if gbtp ~= tpin and gbrh ~= rhin then
      print(tpin,rhin)
      gbtp = tpin
      gbrh = rhin
    end
    
    if(rhin < 67) then --湿度小于67%，浇一次水,持续两秒钟
      pumpmodule.WaterPumpOn()
      pumpofftime = tmr.create()
      pumpofftime:register(2000,tmr.ALARM_SINGLE, function() pumpmodule.WaterPumpOff() end)
      pumpofftime:start()  
    end
    if(tpin > 30) then
      pumpmodule.AirPumOn()
      airpumtime = tmr.create()
      airpumtime:register(2000,tmr.ALARM_SINGLE, function() pumpmodule.AirPumOff() end)
      airpumtime:start()  
    end
  end
end

WaterPump = Pump:new(nil,3,2)

pumpmodule.WaterPumpInit(3,3)--3小时之内不用浇水，管脚使用3
temperture_humidity.DhtInit(5,11)
-- pumpmodule.AirPumInit(8)

maintimer = tmr.create()
maintimer:register(5000, tmr.ALARM_AUTO,function() mainserver()end)
maintimer:start()
