#!mruby
#GR-CITRUS Version 2.15

#ESP8266を一度停止させる(リセットと同じ)
pinMode(5,1)
digitalWrite(5,0)   # LOW:Disable
delay 500
digitalWrite(5,1)   # LOW:Disable

Usb = Serial.new(0,115200)

if( System.useWiFi() == 0)then
    Usb.println "WiFi Card can't use."
   System.exit() 
end
Usb.println "WiFi Ready"

#Usb.println "WiFi Get Version"
#Usb.println WiFi.version

WiFi.disconnect
WiFi.setMode 3  #Station-Mode & SoftAPI-Mode
WiFi.connect("TAROSAY","37000")
#WiFi.connect("000740DE0D79","")
WiFi.multiConnect 1

Usb.println "HTTP GET Start"
res = WiFi.httpGetSD("geturl1.tmp","github.com:443/tarosay/iotlt/blob/master/docs/index.html")
res = WiFi.httpGetSD("geturl2.tmp","github.com/tarosay/iotlt/blob/master/docs/index.html")
#res = WiFi.httpGetSD("main.tmp","www.geocities.jp/momoonga/iot/geturl.txt")
WiFi.disconnect

if(res != 1)then
  Usb.println "Failed."
  #自分をリセットします
  System.reset
  System.exit
end
    