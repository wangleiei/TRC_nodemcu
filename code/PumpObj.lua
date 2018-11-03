-- PumpObj = {pin = 0,flag_pumpon = 9,Inhour = 0}
-- function PumpObj:new (o,pin,hour)
--   o = o or {}
--   setmetatable(o, self)
--   self.__index = self

-- 	pin = pin or 0
--   self.pin = pin 

--   flag_pumpon = flag_pumpon or 0
--   self.flag_pumpon = flag_pumpon

-- 	Inhour = Inhour or 0  
--   self.Inhour = Inhour*3600*1000 
--   return o
-- end
-- -- 基础类方法 printArea
-- function PumpObj:PumOn ()
-- 	if(self.flag_pumpon ~= 1) then
-- 		print("pumpon")	
-- 		gpio.write(self.pin,gpio.HIGH) 
-- 		print("pumpon")	

-- 		if(self.Inhour ~= 0)then
-- 			self.flag_pumpon = 1
-- 			self.pumpontimer = tmr.create()
-- 			self.pumpontimer:register(self.Inhour, tmr.ALARM_SINGLE, function() self.flag_pumpon = 0 end)
-- 			self.pumpontimer:start()
-- 		end
-- 	end
-- end
-- function PumpObj:PumOff()
-- 	gpio.write(self.pin,gpio.LOW) 
-- 	print("pumpoff") 	
-- end

-- pin = 2
-- WaterPump = PumpObj:new(nil,pin,2)
-- WaterPump:PumOff()
WaterPumOn_flag_pumpon = 2
function WaterPumOn (data)
	if(WaterPumOn_flag_pumpon ~= 1) then
		print("pumpon")	
		gpio.write(1,gpio.HIGH) 
		if(data ~= 0)then
			WaterPumOn_flag_pumpon = 1
			Waterpumpontimer = tmr.create()
			Waterpumpontimer:register(1*3600*1000 , tmr.ALARM_SINGLE, function() WaterPumOn_flag_pumpon = 0 end)
			Waterpumpontimer:start()
		end
	end
end
function WaterPumOff()
	gpio.write(1,gpio.LOW) 
	print("pumpoff") 	
end
function WaterPumOn_sleepmode()
		print("pumpon")	
		gpio.write(1,gpio.HIGH) 
end




AirPumOn_flag_pumpon = 2
function AirPumOn (data)
	if(AirPumOn_flag_pumpon ~= 1) then
		print("pumpon")	
		gpio.write(2,gpio.HIGH) 
		if(data ~= 0)then
			AirPumOn_flag_pumpon = 1
			Airpumpontimer = tmr.create()
			Airpumpontimer:register(1*3600*1000 , tmr.ALARM_SINGLE, function() AirPumOn_flag_pumpon = 0 end)
			Airpumpontimer:start()
		end
	end
end
function AirPumOff()
	gpio.write(2,gpio.LOW) 
	print("pumpoff") 	
end
