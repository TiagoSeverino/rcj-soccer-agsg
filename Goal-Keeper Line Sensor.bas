;######################## LINHA Guarda Redes N3 2016 #############################
#picaxe 20x2

'setfreq m64

let b4=220   'valor da b1
let b5=220   'valor da b2
let b6=200   'valor da b3




inicio:
readadc 9, b1
readadc 8, b2
readadc 7, b3
'debug
if  b1>b4 or b2>b5 or b3>b6 then ligado
low c.4
goto inicio


ligado:
high c.4
pause 300'700'500  'PAUSE  64Mhz 2000 ORIGINAL 500
goto inicio