'SRF02 para picaxe 18x1
setfreq m8

let w3= 20 + 25  'leitura da b1+10
let w4= 20 + 25  'leitura da b2+10

inicio:
readadc 1, w1
readadc 0, w2
if w1>w3 and w2>w4 then led_verde_temp
if w1>w3 and w2<w4 then led_verde_temp
if w1<w3 and w2>w4 then led_verde_temp
if w1<w3 and w2<w4 then apagado
goto inicio

'inicio:
'i2cslave $E0,i2cfast,i2cbyte	' Join i2c with SRF02
'i2cwrite 0,(81)		' Send command for ranging
'pause 50			' wait for ranging to complete
'i2cread 2,(b1, b0)	' Read in  high byte and low byte (escreve na W0)
'if w0>155  then led_vermelho '150
'if w0>40 and w0<156  then apagado   '151
'if w0<41 then led_verde
'goto inicio

'led_vermelho:
'high 7
'low 6
'goto inicio

'led_verde:
'low 7
'high 6
'goto inicio

led_verde_temp:
low 7
high 6
pause 1500
goto inicio

apagado:
low 6
low 7
goto inicio