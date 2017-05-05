#!mruby
#GR-CITRUS Version 2.28

Usb = Serial.new(0,115200)

10.times do
  Usb.println "Hello GR-CITRUS World 1"
  delay 500
end

