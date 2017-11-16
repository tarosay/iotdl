#!mruby
#GR-CITRUS Version 2.35
Usb = Serial.new(0,115200)
10.times do
  led
  delay 500
end
#wifiload.mrbをmain.mrbとして上書きコピー
Usb.println "wifiload.mrb を main.mrb にコピー中"
MemFile.cp("wifiload.mrb", "main.mrb",1)
