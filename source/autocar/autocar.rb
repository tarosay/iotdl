#!mruby
#Ver.2.33
#TB6612FNG L-L->STOP. L-H->CCW, H-L->CW, H-H->ShortBrake
MaxVero = 150        #モータ速度速度の最大値を指定しています。0～255
RotVero = 120
Rottime = 300
RotPm = [RotVero, Rottime]
Vero = [4,10]       #モータの速度を決定するGR-CITRUSのピンが4番と10番です。
Num = [18,3,15,14]  #モータの回転方向などを制御するビット、1モータ2ビットです。18,3番、15と14番がペアです
Sens = 17           #アナログ距離センサ
Lev = [1,16]        #ロボホンロボホンのレバー
WiFiEN = 5          #WiFiのEN:LOWでDisableです
MvFlg = false
randomSeed(micros)

Usb = Serial.new(0)
for i in Num do
  pinMode(i,OUTPUT)
end
for i in Lev do
  pinMode(i, 2) #プルアップ
end
pinMode(WiFiEN, OUTPUT)

#WiFiをDisableにします
digitalWrite(WiFiEN, LOW)
    
#-------
# レバー状態状態を取得します
#-------
def lever()
  digitalRead(Lev[0]) + 2 * digitalRead(Lev[1])
end

#-------
# レバー状態状態を取得します
#-------
def lever()
  digitalRead(Lev[0]) + 2 * digitalRead(Lev[1])
end

#-------
# タンクを止めます
#-------
def mstop()
    digitalWrite(Num[0],LOW)  #A1
    digitalWrite(Num[1],LOW)  #A2
    digitalWrite(Num[2],LOW)  #B1
    digitalWrite(Num[3],LOW)  #B2
end
#-------
# タンク前進させます
#-------
def mstart()
  p = 0
  digitalWrite(Num[0],LOW)  #A1
  digitalWrite(Num[1],HIGH)   #A2
  digitalWrite(Num[2],LOW)  #B1
  digitalWrite(Num[3],HIGH)   #B2
  MaxVero.times do
    delay 5
    pwm(Vero[0], p)
    pwm(Vero[1], p)
    p += 1
    if(analogRead(Sens) > 450)then
      #ランダムで右か左回転する
      ro = random(2)
      if ro == 0 then
        Usb.println "Left Rotation"
        rot(HIGH, LOW, RotPm)
      else
        Usb.println "Right Rotation"
        rot(LOW, HIGH, RotPm)
      end
      mstop
      MvFlg = false
      return
    end
  end
end
#-------
# タンクを、t ms回転させます
#-------
def rot(r0,r1,pm)
  led HIGH
  digitalWrite(Num[0],r1)  #A1
  digitalWrite(Num[1],r0)  #A2
  digitalWrite(Num[2],r0)  #B1
  digitalWrite(Num[3],r1)  #B2
  p = 0
  ps = 1
  (2 * pm[0]).times do
    delay 5
    pwm(Vero[0], p)
    pwm(Vero[1], p)
    p += ps
    if(p == pm[0])then
      delay pm[1]
      ps = -1
    end
  end
end
#-----------------------------------------
Usb.println("System Start")

if(lever == 0)then
    System.exit
end

Usb.println("System Start")

randomSeed(micros)
cons = [0,0,0,0] #front,left,right,break
cnt = 0
mstart
mvFlg = true
while true do
  lvr = lever
  Usb.println lvr.to_s

  sc = cons[lvr] + 1
  for i in 0..3 do
    if cons[i] == 4 then
      if i == 3 then
        sc = 0
      else
        mstop
        System.setrun "wifiload.mrb"
        System.exit
      end
    end
    cons[i] = 0
  end
  cons[lvr] = sc
  #Usb.println cnt.to_s
  5.times do
    delay 50
    #Usb.println analogRead(Sens).to_s
    if(analogRead(Sens) > 420)then
      #ランダムで右か左回転する
      ro = random(2)
      if ro == 0 then
        Usb.println "Left Rotation"
        rot(HIGH, LOW, RotPm)
      else
        Usb.println "Right Rotation"
        rot(LOW, HIGH, RotPm)
      end
      mstop
      MvFlg = false
    else
      if MvFlg == false then
        MvFlg = true
        mstart
      end
    end
  end

  if lvr != 3 then
    if cnt > 6 then break end
    cnt += 1
  else
    cnt = 0
  end
  led
end

pwm(Vero[0], 0)
pwm(Vero[1], 0)
digitalWrite(Num[0],HIGH)
digitalWrite(Num[1],HIGH)
digitalWrite(Num[2],HIGH)
digitalWrite(Num[3],HIGH)
System.exit
