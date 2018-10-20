pumppin = 2
flag_pumpon = 9

rh = 40

function gettemphum(...) rh = rh+1 return 223,rh end
function pumpon()gpio.mode(pumppin,gpio.OUTPUT) gpio.write(pumppin,gpio.LOW) print("pumpon") end
function pumpoff()gpio.mode(pumppin,gpio.OUTPUT) gpio.write(pumppin,gpio.HIGH) print("pumpoff") end
-- in 5 minutes dont water
function pumpondeal( ... ) 
	if(flag_pumpon ~= 1)then
		pumpon()
		flag_pumpon = 1
		pumpontimer = tmr.create()
		pumpontimer:register(5000, tmr.ALARM_SINGLE, function() flag_pumpon = 0 end)
		pumpontimer:start()
	end
end
function  mainserver(  )
	-- body
	tp1,rh1 = gettemphum()
	-- 湿度小于x water 1 secnond
	if(rh1 < 67)then 
		pumpondeal()
		pumpofftime = tmr.create()
		pumpofftime:register(2000, tmr.ALARM_SINGLE, function() pumpoff() end)
		pumpofftime:start()	
	end
end

maintimer = tmr.create()
maintimer:register(500, tmr.ALARM_AUTO,function() mainserver()end)
maintimer:start()	