;##################################### LINHA ATACANTE 2016 #########################################
#picaxe 18x

setfreq m8
let w3=145
let w4=180
let w5=145

inicio:
readadc 0, w0; Esquerda
readadc 1, w1; Meio
readadc 2, w2; Direita

'debug
if w0>w3 then led_red_temp_meio
if w1>w4 then led_red_temp_meio
if w2>w5 then led_red_temp_meio
low 5
low 6
goto inicio

led_red_temp_meio:
high 5
high 6
pause 1000
goto inicio