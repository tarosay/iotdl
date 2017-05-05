#!mruby
#GR-CITRUS Version 2.15

#ESP8266を一度停止させる(リセットと同じ)
pinMode(5,1)
digitalWrite(5,0)   # LOW:Disable
delay 500
digitalWrite(5,1)   # LOW:Disable

Usb = Serial.new(0,115200)

if( !System.use?('SD') || !System.use?('WiFi'))then
    Usb.println "SD Card or WiFi can't use."
   System.exit() 
end
Usb.println "SD & WiFi Ready"

#-------
#ボディを取り出します
#-------
def getBody(bodyname, tmpname)
  SD.open(0, tmpname, 0)
  c = SD.read(0)
  crlf = 0
  while(c >= 0)do
    if(c == 0xd || c == 0xa)then
      crlf += 1
      if(crlf == 4)then
          break
      end
    else
      crlf = 0
    end
    c = SD.read(0)
  end
  
  SD.open(1, bodyname, 2)
  while(c >= 0)do
    Usb.write(c.chr, 2)
    SD.write(1, c.chr, 1)
    c = SD.read(0)
  end
  SD.close(1)
  SD.close(0)
end

#-----------------------------------------
Usb.println("System Start")

WiFi.disconnect
WiFi.setMode 3  #Station-Mode & SoftAPI-Mode
WiFi.connect("TAROSAY","37000")
#WiFi.connect("000740DE0D79","")
WiFi.multiConnect 1

Usb.println "HTTP GET Start"
res = WiFi.httpGetSD("geturl.tmp","tarosay.github.io/iotdl/data/geturl.txt")
#res = WiFi.httpGetSD("geturl.tmp","tarosay.github.io/iotdl/data/main.mrb")
WiFi.disconnect

if(res != 1)then
  Usb.println "Failed."
  #自分をリセットします
  System.reset
  System.exit
end

#取得するmrbファイルのURLを取り出します    
getBody("geturl.txt", "geturl.tmp")
