-- 文件名为 pumpmodule.lua

-- Meta class
Pump = {pin = 0}

-- 基础类方法 new
function Pump:new (o,pin,hour)
  o = o or {}
  setmetatable(o, self)
  self.pin = pin
  self.flag_pumpon = 9
  self.Inhour = hour*3600*1000
  return o
end
-- 基础类方法 printArea
function Pump:PumOn()
	if(self.flag_pumpon ~= 1) then
		gpio.write(self.pin,gpio.HIGH) 
		print("pumpon")	

		if(self.Inhour != 0)then
			self.flag_pumpon = 1
			pumpontimer = tmr.create()
			pumpontimer:register(self.Inhour, tmr.ALARM_SINGLE, function() self.flag_pumpon = 0 end)
			pumpontimer:start()
		end
	end
end
function Pump:PumOff()
	gpio.write(self.pin,gpio.LOW) 
	print("pumpoff") 	
end