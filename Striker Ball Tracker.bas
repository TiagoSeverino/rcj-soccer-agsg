
'foi alterado o que está a verde (frente direito e frente esquerdo

setfreq m64

inicio:
readadc 10,b0 '0
readadc 8,b1  '2
readadc 7,b2  '3
readadc 6,b3  '4
readadc 5,b4  '5
readadc 4,b5  '6
readadc 1,b6  '7  pin 1 no novo e pin 3 no antigo  
readadc 2,b7  '8


if b0>250 and b1>250 and b2>250 and b3>250 and b4>250 and b5>250 and b6>250 and b7>250 then parado
if b0<b1 and b0<b2 and b0<b3 and b0<b4 and b0<b5 and b0<b6 and b0<b7 then frente 
if b1<b0 and b1<b2 and b1<b3 and b1<b4 and b1<b5 and b1<b6 and b1<b7 then frente_direito
if b2<b0 and b2<b1 and b2<b3 and b2<b4 and b2<b5 and b2<b6 and b2<b7 then frente_direito 'direito
if b3<b0 and b3<b2 and b3<b1 and b3<b4 and b3<b5 and b3<b6 and b3<b7 then direito
if b4<b0 and b4<b2 and b4<b3 and b4<b1 and b4<b5 and b4<b6 and b4<b7 then esquerdo
if b5<b0 and b5<b2 and b5<b3 and b5<b4 and b5<b1 and b5<b6 and b5<b7 then esquerdo
if b6<b0 and b6<b2 and b6<b3 and b6<b4 and b6<b5 and b6<b1 and b6<b7 then frente_esquerdo'esquerdo
if b7<b0 and b7<b2 and b7<b3 and b7<b4 and b7<b5 and b7<b6 and b7<b1 then frente_esquerdo
goto inicio


frente:
low c.4'b.5
high c.0' b.6
low b.7
low c.5
goto inicio

frente_esquerdo:
high c.4'b.5
low c.0'b.6
low b.7
low c.5
goto inicio

frente_direito:
low c.4'b.5
low c.0'b.6
high b.7
low c.5
goto inicio

esquerdo:
high c.4'b.5
high c.0'b.6
low b.7
low c.5
goto inicio


direito:
low c.4'b.5
high c.0'b.6
high b.7
low c.5
goto inicio

parado:
low c.4'b.5
low c.0'b.6
low b.7
low c.5
goto inicio

frente_esquerdo_1:
high c.4'b.5
low c.0'b.6
low b.7
high c.5
goto inicio

frente_direito_1:
low c.4'b.5
low c.0'b.6
high b.7
high c.5
goto inicio