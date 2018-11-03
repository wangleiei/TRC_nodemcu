DhtObj = {pin = 0,flag_pumpon = 9,Inhour = 0}

function DhtObj:new (o,pin,devnum)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.pin = pin
  self.devnum = devnum
  return o
end
function DhtObj:Read() 
  -- print("read")
  self.status,self.temp,self.humi,self.temp_dec,self.humi_dec = dht.read(self.pin)
  if self.status == dht.OK then
    if 11 == self.devnum then
      return 0,self.temp,self.humi
    else
      return 0,self.humi/100,self.temp/10--DHT12特殊处理
      end
  else
    return 1,0,0
  end
end

