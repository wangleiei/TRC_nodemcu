pumppin = 3
flag_pumpon = 9
function gettemphum()
  pin = 5
  status,temp,humi,temp_dec, humi_dec = dht.read(pin)
  if status == dht.OK then
    return 0,temp,humi
  else
    return 1,0,0
  end
end
function pumpon()
	gpio.mode(pumppin,gpio.OUTPUT) 
	gpio.write(pumppin,gpio.HIGH) 
	print("pumpon") 
end
function pumpoff() 
	gpio.mode(pumppin,gpio.OUTPUT) 
	gpio.write(pumppin,gpio.LOW) 
	print("pumpoff") 
end
function pumpondeal() 
  if(flag_pumpon ~= 1)then
    pumpon()
    flag_pumpon = 1
    pumpontimer = tmr.create()
    -- 五小时内浇过水，就不用浇水了
    pumpontimer:register(1000*60*60*5, tmr.ALARM_SINGLE, function() flag_pumpon = 0 end)
    pumpontimer:start()
  end
end
gbtp = 0
gbrh = 0
function  mainserver()
  ret,tp1,rh1 = gettemphum()
  if(ret == 0) then
  	if gbtp ~=tp1 and gbrh ~= rh1 then
    	print(tp1,rh1)
			gbtp = tp1
			gbrh = rh1
    end
    if(rh1 < 67)then --湿度小于67%，浇一次水
      pumpondeal()
      pumpofftime = tmr.create()
      pumpofftime:register(2000,tmr.ALARM_SINGLE, function() pumpoff() end)
      pumpofftime:start()  
    end
  end
end
maintimer = tmr.create()
maintimer:register(5000, tmr.ALARM_AUTO,function() mainserver()end)
maintimer:start()
