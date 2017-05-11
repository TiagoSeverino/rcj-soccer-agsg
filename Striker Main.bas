;############################################ ATACANTE 2016 ###############################
#picaxe 40x2

;#################### Constantes ########################
;Baliza
symbol BALIZA_AVANCAR		= 780 ;Centrar Baliza

;Bola
symbol BOLA_DRIBULADOR		= 39  ;Bola No Dribulador
symbol BOLA_ENCOSTADA		= 70  ;Bola Quase No Dribulador
symbol BOLA_CONTORNAR_PERTO	= 160  ;Bola No Dribulador
symbol BOLA_CONTORNAR		= 280  ;Bola No Dribulador

;Linha
symbol LINHA_PAREDE_FRENTE	= 700 ;Sonar Frente Linha
symbol LINHA_PAREDE_LADO	= 700 ;Sonar Lado Linha
symbol LINHA_PAREDE_TRAZ	= 40  ;Sonar Traz Linha
symbol LINHA_TEMPO		= 500 ;Tempo Que O Robo Faz A Rotina De Sair Da Linha


;################# Calibração da bussola ###############
iniciar:
if pinA.2=0 then inicio
if pinA.2=1 then afinar_bussola
goto iniciar

afinar_bussola:
gosub bussola
if b9<2 or b9>254    then liga_led_verde
if b9>1 and b9<124   then desliga_led_verde
if b9>125 and b9<130 then virado_contrario
if b9>129 and b9<255 then desliga_led_verde
goto iniciar

liga_led_verde:
high B.4
goto iniciar

desliga_led_verde:
low B.4
goto iniciar

virado_contrario:
high B.4
pause 50
low B.4
pause 50
goto iniciar

;########################## Atacante Main ###################################

;SeguirBola
inicio:
if pinD.2=1 then linha

gosub sonar_frente
if w1<=BOLA_DRIBULADOR then frente_baliza
if w1>BOLA_ENCOSTADA   then inicio_1

if pinD.7=0 and pinD.6=1 and pinD.5=0 then avancar_ll
if pinD.7=1 and pinD.6=1 and pinD.5=0 then rodar_esq
if pinD.7=0 and pinD.6=1 and pinD.5=1 then rodar_dir

inicio_1:
if pinD.7=0 and pinD.6=0 and pinD.5=0 then parado
if pinD.7=0 and pinD.6=1 and pinD.5=0 then frente_1
if pinD.7=1 and pinD.6=1 and pinD.5=0 then esquerda_l
if pinD.7=1 and pinD.6=0 and pinD.5=0 then esquerda
if pinD.7=1 and pinD.6=1 and pinD.5=1 then esquerda_r
if pinD.7=1 and pinD.6=0 and pinD.5=1 then direita_r
if pinD.7=0 and pinD.6=0 and pinD.5=1 then direita
if pinD.7=0 and pinD.6=1 and pinD.5=1 then direita_l
goto inicio

frente_1:
if w1<=BOLA_CONTORNAR_PERTO then contornar_perto
if w1<=BOLA_CONTORNAR 	    then contornar
if w1>BOLA_CONTORNAR	    then avancar
goto inicio

sonar_frente:
low b.7
pulsout b.7, 2
pulsin d.4, 1, w1
low b.7
return

sonar_esq:
low b.6
pulsout b.6, 2
pulsin d.1, 1, w2
low b.6
return

sonar_dir:
low b.5
pulsout b.5, 2
pulsin d.0, 1, w3
low b.5
return

bussola:
i2cslave $C0,i2cfast,i2cbyte ' Define i2c slave address for the CMPS03
readi2c 0,(b8)  ' ler CMPS03 Software Revision
readi2c 1,(b9)
return

sonar_traz:
i2cslave $E0,i2cfast,i2cbyte
i2cwrite 0,(81)
pause 70
i2cread 2,(b11, b10)    ' Read in  high byte and low byte (escreve na W5)
pause 10
return

frente_baliza:
gosub bussola
if b9<12 or b9>242 then frente_bola_baliza
if b9<128 		 then rodar_esq
if b9>127		 then rodar_dir
goto inicio

frente_bola_baliza:
gosub sonar_esq
gosub sonar_dir
if w2>BALIZA_AVANCAR and w3>BALIZA_AVANCAR   then avancar_baliza
if w2<=BALIZA_AVANCAR and w3>BALIZA_AVANCAR  then obliqua_dir
if w2>BALIZA_AVANCAR and w3<=BALIZA_AVANCAR  then obliqua_esq
if w2<=BALIZA_AVANCAR and w3<=BALIZA_AVANCAR then avancar_baliza
goto inicio

contornar:
gosub bussola
if b9<12 or b9>242 then avancar
if b9<128 		 then esquerda_c
if b9>127 		 then direita_c
goto inicio

contornar_perto:
gosub bussola
if b9<12 or b9>242 then avancar_ll
if b9<128 		 then esquerda_c1
if b9>127 		 then direita_c1
goto inicio

'##############LINHA###########LINHA############LINHA##############LINHA############
'##############LINHA###########LINHA############LINHA##############LINHA############
linha:
gosub r_travado
pause 100
goto linha_virar

linha_virar:
gosub bussola

if b9<13		   then 	  linha_xx_1x_travado
if b9>10  and b9<21  then gosub l_rodar_esq_l
if b9>20  and b9<64  then gosub l_rodar_esq
if b9>63  and b9<108 then gosub l_rodar_dir
if b9>107 and b9<117 then gosub l_rodar_dir_l
if b9>116 and b9<138 then 	  parado_linha_virado
if b9>137 and b9<147 then gosub l_rodar_esq_l
if b9>146 and b9<191 then gosub l_rodar_esq
if b9>190 and b9<235 then gosub l_rodar_dir
if b9>134 and b9<243 then gosub l_rodar_dir_l
if b5>242		   then 	  linha_xx_1x_travado
goto linha_virar

l_rodar_esq_l:
gosub r_esq_d
pwmout c.1,10,3
pwmout c.2,10,3
return

l_rodar_esq:
gosub r_esq_d
pwmout c.1,10,4
pwmout c.2,10,4
return

l_rodar_dir_l:
gosub r_dir_d
pwmout c.1,10,3
pwmout c.2,10,3
return

l_rodar_dir:
gosub r_dir_d
pwmout c.1,10,4
pwmout c.2,10,4
return

linha_xx_1x_travado:
gosub r_travado
goto linha_xx_1x

linha_xx_1x:
gosub sonar_traz
gosub sonar_frente
if W1<=LINHA_PAREDE_FRENTE and W5<=LINHA_PAREDE_TRAZ then parado_linha
if W1>LINHA_PAREDE_FRENTE and W5>LINHA_PAREDE_TRAZ   then linha_xx_1          
if W1>LINHA_PAREDE_FRENTE and W5<=LINHA_PAREDE_TRAZ  then linha_xx_frente
if W1<=LINHA_PAREDE_FRENTE and W5>LINHA_PAREDE_TRAZ  then linha_xx_1
goto inicio

parado_linha:
if W1<=BOLA_DRIBULADOR then linha_xx_1
if W1>BOLA_DRIBULADOR  then linha_xx_virado
goto linha_xx_1x

linha_xx_1:
gosub sonar_dir
gosub sonar_esq                                                 
if W2<=LINHA_PAREDE_LADO and W3<=LINHA_PAREDE_LADO then recuar300a
if W2>LINHA_PAREDE_LADO and W3>LINHA_PAREDE_LADO   then inicio
if W2>LINHA_PAREDE_LADO and W3<=LINHA_PAREDE_LADO  then recua_oblq_esqerda_x 
if W2<=LINHA_PAREDE_LADO and W3>LINHA_PAREDE_LADO  then recua_oblq_direita_x
goto inicio

recuar300a:
gosub bussola
if b9<13		   then recuar300
if b9>242		   then recuar300
if b9>5   and b9<128 then rodar_esqerda_k
if b9>127 and b9<250 then rodar_direita_k
goto inicio

recuar300:
gosub r_traz_d
pwmout c.1,10,10
pwmout c.2,10,12
goto linha_xx_1

rodar_esqerda_k:
gosub l_rodar_esq
goto linha_xx_1

rodar_direita_k:
gosub l_rodar_dir
goto linha_xx_1

linha_xx_frente:
gosub sonar_dir
gosub sonar_esq
if W2<=LINHA_PAREDE_LADO and W3<=LINHA_PAREDE_LADO then frente300  
if W2>LINHA_PAREDE_LADO and W3>LINHA_PAREDE_LADO   then inicio
if W2>LINHA_PAREDE_LADO and W3<=LINHA_PAREDE_LADO  then frente_oblq_esqerda_x 
if W2<=LINHA_PAREDE_LADO and W3>LINHA_PAREDE_LADO  then frente_oblq_direita_x
goto inicio

frente300:
gosub r_frente_d
pwmout c.1,10,10
pwmout c.2,10,12
goto linha_xx_frente

'########

parado_linha_virado:
gosub r_travado
goto linha_xx_virado

linha_xx_virado:
gosub r_travado

gosub sonar_traz
gosub sonar_frente

if W1<=LINHA_PAREDE_FRENTE and W5<=LINHA_PAREDE_TRAZ then parado_linha_virado
if W1>LINHA_PAREDE_FRENTE and W5>LINHA_PAREDE_TRAZ   then linha_xx_virado_1          
if W1>LINHA_PAREDE_FRENTE and W5<=LINHA_PAREDE_TRAZ  then linha_xx_frente
if W1<=LINHA_PAREDE_FRENTE and W5>LINHA_PAREDE_TRAZ  then linha_xx_virado_1
goto inicio

linha_xx_virado_1:
gosub sonar_dir
gosub sonar_esq                                        
if W2<=LINHA_PAREDE_LADO and W3<=LINHA_PAREDE_LADO then recuar300virado
if W2>LINHA_PAREDE_LADO and W3>LINHA_PAREDE_LADO   then inicio
if W2>LINHA_PAREDE_LADO and W3<LINHA_PAREDE_LADO   then recua_oblq_esqerda_virado 
if W2<=LINHA_PAREDE_LADO and W3>LINHA_PAREDE_LADO  then recua_oblq_direita_virado
goto inicio

recuar300virado:
gosub r_traz_d
pwmout c.1,10,10
pwmout c.2,10,12
goto linha_xx_virado_1

'???????????????????????????????

recua_oblq_direita_x:
gosub sonar_frente
if w1<=LINHA_PAREDE_FRENTE then recua_oblq_direita_x1
if w1>LINHA_PAREDE_FRENTE  then lado_direito_xx
goto inicio

recua_oblq_direita_virado:
gosub sonar_frente
if w1<=LINHA_PAREDE_FRENTE then recua_oblq_direita_x1_virado
if w1>LINHA_PAREDE_FRENTE  then lado_direito_xx
goto inicio

recua_oblq_direita_x1:
gosub recua_oblq_dir
pause LINHA_TEMPO
goto inicio

recua_oblq_direita_x1_virado:
gosub recua_oblq_dir
pause LINHA_TEMPO
goto parado_linha_kk

recua_oblq_esqerda_x:
gosub sonar_frente
if w1<=LINHA_PAREDE_FRENTE then recua_oblq_esquerda_x1
if w1>LINHA_PAREDE_FRENTE  then lado_esquerdo_xx
goto inicio

recua_oblq_esqerda_virado:
gosub sonar_frente
if w1<=LINHA_PAREDE_FRENTE then recua_oblq_esquerda_x1_virado
if w1>LINHA_PAREDE_FRENTE  then lado_esquerdo_xx
goto inicio

recua_oblq_esquerda_x1:
gosub recua_oblq_esq
pause LINHA_TEMPO
goto inicio

recua_oblq_esquerda_x1_virado:
gosub recua_oblq_esq
pause LINHA_TEMPO
goto parado_linha_kk

lado_esquerdo_xx:
gosub lado_esq
pause LINHA_TEMPO
goto parado_linha_kk

lado_direito_xx:
gosub lado_dir
pause LINHA_TEMPO
goto parado_linha_kk

frente_oblq_esqerda_x:
gosub frente_oblq_esq
pause LINHA_TEMPO
goto parado_linha_kk

frente_oblq_direita_x:
gosub frente_oblq_dir
pause LINHA_TEMPO
goto parado_linha_kk

parado_linha_kk:
gosub r_travado
pause LINHA_TEMPO
goto inicio


recua_oblq_esq:
high C.0, B.2, B.4
low C.5, C.6, C.7, B.0, B.1, B.3
pwmout c.1, 10, 15
pwmout c.2, 10, 17
return

recua_oblq_dir:
low C.0, C.5, C.7, B.1, B.2, B.3
high C.6, B.0, B.4
pwmout c.1, 10, 15
pwmout c.2, 10, 17
return

frente_oblq_dir:
low C.0, C.6, C.7, B.0, B.1, B.2, B.4
high C.5, B.3, B.4
pwmout c.1, 10, 15
pwmout c.2, 10, 17
return

frente_oblq_esq:
low C.0, C.5, C.6, B.0, B.2, B.3, B.4
high C.7, B.1, B.4
pwmout c.1, 10, 15
pwmout c.2, 10, 17
return

lado_dir:
low C.0, C.7, B.1, B.2
high C.5, C.6, B.0, B.3, B.4
pwmout c.1, 10, 15
pwmout c.2, 10, 17
return

lado_esq:
high C.0, C.7, B.1, B.2, B.4
low C.5, C.6, B.0, B.3
pwmout c.1, 10,15
pwmout c.2, 10,17
return

'##############MOTORES###########MOTORES############MOTORES##############MOTORES############
'##############MOTORES###########MOTORES############MOTORES##############MOTORES############

avancar:
gosub r_frente
pwmout c.1,10,20
pwmout c.2,10,22
goto inicio

avancar_baliza:
gosub r_frente_d
pwmout c.1,10,25
pwmout c.2,10,27
goto inicio

avancar_ll:
gosub r_frente_d
pwmout c.1,10,15
pwmout c.2,10,17
goto inicio

avancar_l:
gosub r_frente
pwmout c.1,10,15
pwmout c.2,10,17
goto inicio

obliqua_esq:
gosub r_cont_esq
pwmout c.1,10,25
pwmout c.2,10,27
goto inicio

obliqua_dir:
gosub r_cont_dir
pwmout c.1,10,25
pwmout c.2,10,27
goto inicio

esquerda_c:
low c.0, c.6, c.7, b.1, b.2, b.4
high c.5, b.0, b.3
pwmout c.1,10,15
pwmout c.2,10,15
goto inicio

direita_c:
low c.0, c.5, c.6, b.0, b.3, b.4
high c.7, b.1, b.2
pwmout c.1,10,15
pwmout c.2,10,15
goto inicio

esquerda_c1:
low c.0, c.6, c.7, b.1, b.2
high c.5, b.0, b.3, b.4
pwmout c.1,10,20
pwmout c.2,10,20
goto inicio

direita_c1:
low c.0, c.5, c.6, b.0, b.3
high c.7, b.1, b.2, b.4
pwmout c.1,10,20
pwmout c.2,10,20
goto inicio

esquerda_l:
gosub r_esq
pwmout c.1,10,3
pwmout c.2,10,3
goto inicio

direita_l:
gosub r_dir
pwmout c.1,10,3
pwmout c.2,10,3
goto inicio

esquerda:
gosub r_esq
pwmout c.1,10,10
pwmout c.2,10,10
goto inicio

direita:
gosub r_dir
pwmout c.1,10,10
pwmout c.2,10,10
goto inicio

esquerda_r:
gosub r_esq
pwmout c.1,10,15
pwmout c.2,10,15
goto inicio

direita_r:
gosub r_dir
pwmout c.1,10,15
pwmout c.2,10,15
goto inicio

rodar_dir:
gosub r_dir_d
pwmout c.1,10,15
pwmout c.2,10,10
goto inicio

rodar_esq:
gosub r_esq_d
pwmout c.1,10,10
pwmout c.2,10,15
goto inicio

parado:
gosub r_parado
goto inicio

;Rotinas Principais

r_frente:
low c.0, c.6, b.0, b.2
high c.5, c.7, b.1, b.3
return

r_frente_d:
low c.0, c.6, b.0, b.2
high c.5, c.7, b.1, b.3, b.4
return

r_esq:
high c.0, c.7, b.0, b.3
low c.5, c.6, b.1, b.2, b.4
return

r_esq_d:
high c.0, c.7, b.0, b.3, b.4
low c.5, c.6, b.1, b.2
return

r_dir:
low c.0, c.7, b.0, b.3, b.4
high c.5, c.6, b.1, b.2
return

r_dir_d:
low c.0, c.7, b.0, b.3
high c.5, c.6, b.1, b.2, b.4
return

r_traz_d:
high c.0, c.6, b.0, b.2, b.4
low c.5, c.7, b.1, b.3
return

r_parado:
low c.0, c.6, b.0, b.2, c.5, c.7, b.1, b.3, b.4
return

r_travado:
high c.0, c.6, b.0, b.2, c.5, c.7, b.1, b.3, b.4
pwmout c.1,10,50
pwmout c.2,10,50
return

r_cont_dir:
low C.0, C.6, C.7, B.0, B.1, B.2
high C.5, B.3, b.4
return

r_cont_esq:
low C.0, C.5, C.6, B.2, B.3, B.0
high C.7, B.1, b.4
return