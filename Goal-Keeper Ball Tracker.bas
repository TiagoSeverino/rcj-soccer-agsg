

setfreq m64

let b10=125'130'124  'AFINAÇÂO para anular as reflexões nos cantos 


let b11=b10+1

let b14=b10
let b15=b14+1
let b16=b10-20'9

inicio:
readadc 10,b0 '0
readadc 8,b1  '1
readadc 7,b2  '2
readadc 6,b3  '3
readadc 5,b4  '4
readadc 4,b5  '5
readadc 1,b6  '6  (readadc 3) foi alterado para readadc 1
readadc 2,b7  '7


'estão desligados os sensores nas entradas 0 e 4
     ' 1          2          3              5          6          7             01234567
if  b1>b10 and b2>b10 and b3>b10     and b5>b10 and b6>b10 and b7>b10 then centro'apagado
if  b1<b11 and b2>b10 and b3>b10     and b5>b10 and b6>b10 and b7<b11 then centro'frente_01000001

'if b0<b11 and b1>b10 and b2>b10 and b3>b10     and b5>b10 and b6>b10 and b7>b10 then frente

'if b0<b11 and b1<b11 and b2>b10 and b3>b10     and b5>b10 and b6>b10 and b7>b10 then esquerdo_1
'if b0<b11 and b1>b10 and b2>b10 and b3>b10     and b5>b10 and b6>b10 and b7<b11 then direito_1

if  b1<b11 and b2>b10 and b3>b10     and b5>b10 and b6>b10 and b7>b10 then esquerdo '01000 esquerda_01000000
if  b1>b10 and b2>b10 and b3>b10     and b5>b10 and b6>b10 and b7<b11 then direito ' 00010 direita_00000001
if  b1<b11 and b2<b11 and b3>b10     and b5>b10 and b6>b10 and b7>b10 then esquerda_r_01100000
if  b1>b10 and b2<b11 and b3>b10     and b5>b10 and b6>b10 and b7>b10 then esquerda_r_00100000
if  b1>b10 and b2<b11 and b3<b11     and b5>b10 and b6>b10 and b7>b10 then esquerda_r_00110000 
if  b1>b10 and b2>b10 and b3<b11     and b5>b10 and b6>b10 and b7>b10 then esquerda_r_00010000
if  b1>b10 and b2>b10 and b3>b10     and b5<b11 and b6>b10 and b7>b10 then direita_r_00000100
if  b1>b10 and b2>b10 and b3>b10     and b5<b11 and b6<b11 and b7>b10 then direita_r_00000110 
if  b1>b10 and b2>b10 and b3>b10     and b5>b10 and b6<b11 and b7>b10 then direita_r_00000010 '««««
if  b1>b10 and b2>b10 and b3>b10     and b5>b10 and b6<b11 and b7<b11 then direita_r_00000011
goto inicio

centro:
if b1>b14 and b0>b14 and b7>b14 then apagado
if b1>b14 and b0<b15 and b7>b14 then frente11
if b1<b15 and b0>b14 and b7>b14 then frente 'esq
if b1>b14 and b0>b14 and b7<b15 then frente 'dir
if b1<b14 and b0<b15 and b7>b15 then esquerdo_1
if b1>b15 and b0<b15 and b7<b14 then direito_1
goto inicio

frente11:
if b0<68 then xuto     'NO Nº2 Valor 131
if b0>67 and b0<b16 then frente
if b0>b16 then apagado
goto inicio

xuto:
low b.6'0
high c.5'1
high c.4'2
high c.0'3
low b.7'4
'01110
goto inicio


apagado: 
low b.6'0
low c.5'1
low c.4'2
low c.0'3
low b.7'4
'00000
goto inicio

frente:
low b.6'0
low c.5'1
high c.4'2
low c.0'3
low b.7'4
'00100
goto inicio

'###########################
esquerda_01000000:
low b.6'0
low c.5'1
low c.4'2
high c.0'3
low b.7'4
'01000
goto inicio

direita_00000001:
low b.6'0
high c.5'1
low c.4'2
low c.0'3
low b.7'4
'00010
goto inicio

esq:
if b1<b16 then esq_1
if b1>b16 then apagado
goto inicio

esq_1:
low b.6'0
low c.5'1
low c.4'2
high c.0'3
low b.7'4
'01000
goto inicio

esquerdo:
low b.6'0
low c.5'1
low c.4'2
high c.0'3
low b.7'4
'01000
goto inicio

dir:
if b7<b16 then dir_1
if b7>b16 then apagado
goto inicio

dir_1:
low b.6'0
high c.5'1
low c.4'2
low c.0'3
low b.7'4
'00010
goto inicio

direito:
low b.6'0
high c.5'1
low c.4'2
low c.0'3
low b.7'4
'00010
goto inicio
'##############################

esquerdo_1:
low b.6'0
low c.5'1
low c.4'2
high c.0'3
low b.7'4
'01100
goto inicio

direito_1:
low b.6'0
high c.5'1
low c.4'2
low c.0'3
low b.7'4
'00110
goto inicio


frente_01000001:
low b.6'0
high c.5'1
low c.4'2
high c.0'3
low b.7'4
'01010
goto inicio

esquerda_r_00100000:
low b.6'0
low c.5'1
low c.4'2
low c.0'3
high b.7'4
'10000
goto inicio


esquerda_r_01100000:'nn
low b.6'0
low c.5'1
low c.4'2
high c.0'3
high b.7'4  
'11000
goto inicio

esquerda_r_00110000:
low b.6'0
low c.5'1
high c.4'2
high c.0'3
high b.7'4
'11100
goto inicio


direita_r_00000010:
high b.6'0
low c.5'1
low c.4'2
low c.0'3
low b.7'4
'00001
goto inicio

direita_r_00000011: 'nnn
high b.6'0
high c.5'1
low c.4'2
low c.0'3
low b.7'4
'00011
goto inicio

direita_r_00000110:
high b.6'0
high c.5'1
high c.4'2
low c.0'3
low b.7'4
'00111
goto inicio

esquerda_r_00010000:
low b.6'0
low c.5'1
high c.4'2
low c.0'3
high b.7'4
'10100
goto inicio


direita_r_00000100:
high b.6'0
low c.5'1
high c.4'2
low c.0'3
low b.7'4
'00101
goto inicio


