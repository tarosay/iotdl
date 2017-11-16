#!mruby
#GR-CITRUS Version 2.35
Usb = Serial.new(0,115200)
spn = 250
20.times do
  led
  delay spn
end
#wifiload.mrbをmain.mrbとして上書きコピー
Usb.println "wifiload.mrb を main.mrb にコピー中"
MemFile.cp("wifiload.mrb", "main.mrb",1)
