#!mruby
#GR-CITRUS Version 2.50
#Usb = Serial.new(0,115200)
spn = 250
20.times do
  led
  delay spn
end
#wifiload.mrbをmain.mrbとして上書きコピー
puts "wifiload.mrb を main.mrb にコピー中"
MemFile.cp("wifiload.mrb", "main.mrb",1)
