-- 文件名为 temperture_humidity.lua
-- 定义一个名为 temperture_humidity 的模块
temperture_humidity = {}
temperture_humidity.pin = 0
temperture_humidity.devnum = 11

-- 定义一个常量
-- devnum:11:DHT11,12->DHT12
function temperture_humidity.DhtInit(pin,devnum)
  temperture_humidity.pin = pin
  temperture_humidity.devnum = devnum
end
function temperture_humidity.ReadTemperHumidity() 
  status,temp,humi,temp_dec, humi_dec = dht.read(temperture_humidity.pin)
  if status == dht.OK then
    if 11 == temperture_humidity.devnum then
      return 0,temp,humi
    else
      return 0,humi/100,temp/10--DHT12特殊处理
      end
  else
    return 1,0,0
  end
end
return temperture_humidity

