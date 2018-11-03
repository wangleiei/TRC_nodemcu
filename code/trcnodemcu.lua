require"PumpObj"
require"DhtObj"

MinRH = 30-- min humidity
MaxTR = 29
function SetMinRH(data)
	MinRH = data
end
function GetMinRH()
	return MinRH
end
function SetMaxTR(data)
	MaxTR = data
end
function GetMaxTR()
	return MaxTR
end
function GetDirtRH()
  gpio.mode(6,gpio.OUTPUT) 
  gpio.write(6,gpio.HIGH)
  tmr.delay(500*1000)

  tempadc = adc.read(0)
  if(tempadc > 415)then 
    tempadc = 415
  end
  if(tempadc < 163)then 
    tempadc = 163
  end
  return 0.29*tempadc-27.85
end
function getdata_fromfile()
  fddata = file.open("initdat.data","r")
  retstr = 0
  -- if(fddata ~= nil)then
    retstr = fddata.read()
    fddata.close()
  -- end
  retstr = tonumber(retstr)
  -- print(retstr)
  return retstr
end
function setdata_fromfile(data)
  fddata = file.open("initdat.data","w")
  fddata.write(tostring(data))
  -- print(tostring(data))
  fddata.close()
end

function  mainserver()
  sleep_minute = 1
  rh_inter = GetDirtRH()

  print("MinRH",GetMinRH(),"dirt humidity",rh_inter)

	if(rh_inter < GetMinRH()) then 
    run_minute = getdata_fromfile()

    print("watered time(min)",run_minute,"sleep time(min)",sleep_minute)

    if(run_minute >= 60) then
      setdata_fromfile(sleep_minute)
      run_minute = 0
    else
      setdata_fromfile(run_minute + sleep_minute)
    end

    if(run_minute == 0)then
      -- water after 60min
      WaterPumOn_sleepmode()
    end
		
    pumpofftime = tmr.create()
		pumpofftime:register(1000,tmr.ALARM_SINGLE, 
      function() 
        WaterPumOff() 
        node.dsleep(sleep_minute*60*1000*1000, 2) 
      end)
		pumpofftime:start()  
  else
    setdata_fromfile(0)
	end  
end
