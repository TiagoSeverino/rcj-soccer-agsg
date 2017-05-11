'picaxe 20x2

setfreq m64

'let b4=130

let b4=15+92    'valor da b1
let b5=15+100    'valor da b2
let b6=15+105   'valor da b3


inicio:
readadc 9, b1
readadc 8, b2
readadc 7, b3
if  b1<b4 and b2<b5 and b3<b6 then desligado
if  b1>b4 and b2>b5 and b3>b6 then ligado
if  b1>b4 and b2<b5 and b3<b6 then ligado
if  b1<b4 and b2>b5 and b3<b6 then ligado
if  b1<b4 and b2<b5 and b3>b6 then ligado
if  b1>b4 and b2>b5 and b3<b6 then ligado
if  b1<b4 and b2>b5 and b3>b6 then ligado
goto inicio


ligado:
high c.4
pause 500  'PAUSE  64Mhz 2000
goto inicio

desligado:
low c.4
goto inicio