symbol flag=b25

iniciar:
if porta input2=0 then inicio
if porta input2=1 then acerto_agulha
goto iniciar

acerto_agulha:
i2cslave $C0,i2cfast,i2cbyte	' Define i2c slave address for the CMPS03
readi2c 0,(b1)		' ler CMPS03 Software Revision
readi2c 1,(b5)
'if b5>0 then desliga_led_verde
'if b5<1 then liga_led_verde
if b5<2 then liga_led_verde
if b5>1  and b5<255 then desliga_led_verde
if b5>254 then liga_led_verde
goto iniciar

liga_led_verde:
high 4
goto iniciar

desliga_led_verde:
low 4
goto iniciar

'»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»
 
inicio:
if pin7=0 and pin6=0 and pin5=0 and pin3=0 and pin2=0 then pos_centro_1
if pin7=0 and pin6=1 and pin5=0 and pin3=0 and pin2=0 then pos_lado_esquerdo_2'pos_centro
if pin7=0 and pin6=0 and pin5=0 and pin3=1 and pin2=0 then pos_lado_direito_2'pos_centro

if pin7=0 and pin6=1 and pin5=0 and pin3=1 and pin2=0 then frente_bola_rap_1
if pin7=0 and pin6=1 and pin5=1 and pin3=1 and pin2=0 then frente_bola_rap_1
if pin7=0 and pin6=0 and pin5=1 and pin3=0 and pin2=0 then parado_acerto

if pin7=1 and pin6=1 and pin5=0 and pin3=0 and pin2=0 then pos_lado_esquerdo_rap'_le
if pin7=1 and pin6=0 and pin5=0 and pin3=0 and pin2=0 then pos_lado_esquerdo_rap
if pin7=0 and pin6=0 and pin5=0 and pin3=1 and pin2=1 then pos_lado_direito_rap'_le
if pin7=0 and pin6=0 and pin5=0 and pin3=0 and pin2=1 then pos_lado_direito_rap
if pin7=0 and pin6=0 and pin5=1 and pin3=0 and pin2=1 then pos_recua
if pin7=0 and pin6=0 and pin5=1 and pin3=1 and pin2=1 then pos_recua_oblq_direita
if pin7=1 and pin6=0 and pin5=1 and pin3=0 and pin2=0 then pos_recua
if pin7=1 and pin6=1 and pin5=1 and pin3=0 and pin2=0 then pos_recua_oblq_esqerda
goto pos_centro


parado_acerto:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		
readi2c 1,(b5)		'  ATACA A "0"				
if b5<8  then parado
if b5>7  and b5<16 then rodar_esquerda_lento_1
if b5>15  and b5<26 then rodar_esquerda_lento_2
if b5>25  and b5<36 then rodar_esquerda_lento
if b5>35  and b5<127 then rodar_esquerda
if b5>126 and b5<219 then rodar_direita
if b5>218 and b5<228 then rodar_direita_lento
if b5>227 and b5<238 then rodar_direita_lento_2
if b5>237 and b5<248 then rodar_direita_lento_1
if b5>247 then parado
goto inicio


pos_lado_direito_2:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)	
readi2c 1,(b5)		
if b5<11 then lado_direito_1
if b5>10 and b5<30 then lado_direito_rap_1
if b5>29  and b5<225 then pos_centro
if b5>224 then lado_direito_1
goto inicio

pos_lado_esquerdo_2:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		
readi2c 1,(b5)		
if b5<30 then lado_esquerdo_1
if b5>29  and b5<225 then pos_centro
if b5>224 and b5<245 then lado_esquerdo_rap_1 
if b5>244 then lado_esquerdo_1
goto inicio

pos_lado_esquerdo_rap_le:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		'
readi2c 1,(b5)		' ATACA A "0"
if b5<30 then lado_esquerdo_rap_le_1
if b5>29  and b5<225 then pos_centro
if b5>224 then lado_esquerdo_rap_le_1
goto inicio

pos_lado_direito_rap_le:
i2cslave $C0,i2cfast,i2cbyte	' 
readi2c 0,(b1)		'
readi2c 1,(b5)		'  ATACA A "0"
if b5<30 then lado_direito_rap_le_1
if b5>29  and b5<225 then pos_centro
if b5>224 then lado_direito_rap_le_1
goto inicio

pos_lado_esquerdo_rap:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		'
readi2c 1,(b5)		
if b5<30 then lado_esquerdo_rap_1
if b5>29  and b5<225 then pos_centro
if b5>224 then lado_esquerdo_rap_1
goto inicio

pos_lado_direito_rap:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		
readi2c 1,(b5)		
if b5<30 then lado_direito_rap_1
if b5>29  and b5<225 then pos_centro
if b5>224 then lado_direito_rap_1
goto inicio

pos_recua_oblq_esqerda:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		
readi2c 1,(b5)		
if b5<30 then recua_oblq_esqerda_2
if b5>29  and b5<225 then pos_centro
if b5>224 then recua_oblq_esqerda_2
goto inicio

pos_recua_oblq_direita:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		
readi2c 1,(b5)		
if b5<30 then recua_oblq_direita_2
if b5>29  and b5<225 then pos_centro
if b5>224 then recua_oblq_direita_2
goto inicio

pos_recua:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		
readi2c 1,(b5)		
if b5<30 then recua_rapido
if b5>29  and b5<225 then pos_centro
if b5>224 then recua_rapido
goto inicio

lado_esquerdo_1:
low 7
PULSOUT 7, 5   
PULSIN 4, 1, w6    ' escreve na w6 a distancia da baliza
if w6>200 then pos_centro_2'if w6>250 then pos_centro_2
if w6<201 then lado_esquerdo'if w6<251 then lado_esquerdo
goto inicio

lado_direito_1:
low 7
PULSOUT 7, 5   
PULSIN 4, 1, w6    ' escreve na w6 a distancia da baliza
if w6>200 then pos_centro_2'250
if w6<201 then lado_direito'251
goto inicio

lado_esquerdo_rap_1:
low 7
PULSOUT 7, 5   
PULSIN 4, 1, w6    ' escreve na w6 a distancia da baliza
if w6>350 then pos_centro_2
if w6<351 then lado_esquerdo_rap
goto inicio

lado_direito_rap_1:
low 7
PULSOUT 7, 5   
PULSIN 4, 1, w6    ' escreve na w6 a distancia da baliza
if w6>350 then pos_centro_2
if w6<351 then lado_direito_rap
goto inicio
 
lado_esquerdo_rap_le_1:
low 7
PULSOUT 7, 5   
PULSIN 4, 1, w6    ' escreve na w6 a distancia da baliza
if w6>350 then pos_centro_2
if w6<351 then lado_esquerdo_rap_le
goto inicio

lado_direito_rap_le_1:
low 7
PULSOUT 7, 5   
PULSIN 4, 1, w6    ' escreve na w6 a distancia da baliza
if w6>350 then pos_centro_2
if w6<351 then lado_direito_rap_le
goto inicio

recua_oblq_esqerda_2:
low 7
PULSOUT 7, 5   
PULSIN 4, 1, w6    'escreve na w6 a distancia da baliza
if w6>80 then recua_oblq_esqerda
if w6<81 then lado_esquerdo_rap
goto inicio

recua_oblq_direita_2:
low 7
PULSOUT 7, 5   
PULSIN 4, 1, w6    ' escreve na w6 a distancia da baliza
if w6>80 then recua_oblq_direita
if w6<81 then lado_direito_rap
goto inicio


pos_centro:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		
readi2c 1,(b5)						
if b5<8  then pronto_a_def 
if b5>7  and b5<16 then rodar_esquerda_lento_1
if b5>15  and b5<26 then rodar_esquerda_lento_2
if b5>25  and b5<36 then rodar_esquerda_lento
if b5>35  and b5<127 then rodar_esquerda
if b5>126 and b5<219 then rodar_direita
if b5>218 and b5<228 then rodar_direita_lento
if b5>227 and b5<238 then rodar_direita_lento_2
if b5>237 and b5<248 then rodar_direita_lento_1
if b5>247 then pronto_a_def 
goto inicio

pos_centro_1:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		
readi2c 1,(b5)						
if b5<13  then mede_trazeira
if b5>12  and b5<16 then rodar_esquerda_lento_1
if b5>15  and b5<26 then rodar_esquerda_lento_2
if b5>25  and b5<36 then rodar_esquerda_lento
if b5>35  and b5<127 then rodar_esquerda
if b5>126 and b5<219 then rodar_direita
if b5>218 and b5<228 then rodar_direita_lento
if b5>227 and b5<238 then rodar_direita_lento_2
if b5>237 and b5<243 then rodar_direita_lento_1
if b5>242 then mede_trazeira
goto inicio


pos_centro_2:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		
readi2c 1,(b5)						
if b5<13  then nocentro_2
if b5>12  and b5<16 then rodar_esquerda_lento_1
if b5>15  and b5<26 then rodar_esquerda_lento_2
if b5>25  and b5<36 then rodar_esquerda_lento
if b5>35  and b5<127 then rodar_esquerda
if b5>126 and b5<219 then rodar_direita
if b5>218 and b5<228 then rodar_direita_lento
if b5>227 and b5<238 then rodar_direita_lento_2
if b5>237 and b5<243 then rodar_direita_lento_1
if b5>242 then nocentro_2
goto inicio

nocentro_2:
low 5
PULSOUT 5, 5   'Ultra Sons e escreve na w8-lado direito
PULSIN 0, 1, w8
if w8>484 and w8<505 then centro
if w8>504  and w8<551 then recua_oblq_direita_le'lado_direito_k 
if w8>550 then recua_oblq_direita_le'lado_direito_k  
if w8<485 then lado_esquerdo_regula_2
goto inicio

lado_esquerdo_regula_2:
low 6          
PULSOUT 6, 5   'Ultra Sons e escreve na w7-lado esquerdo
PULSIN 1, 1, w7
if w7>470 and w7<505 then centro '229
if w7>504 and w7<551 then recua_oblq_esqerda_le'lado_esquerdo_k  
if w7>550 then recua_oblq_esqerda_le'lado_esquerdo_k 
if w7<471 then frente_bola_acerto'                      '???????????????????????????????                          
goto inicio 


mede_trazeira:
low 7
PULSOUT 7, 5   'Ultra Sons e escreve na w6 a distancia da baliza
PULSIN 4, 1, w6                                                  
if w6<250 then pos_centro                                           
if w6>249 and w6<400 then nocentro_2'recua
if w6>399 then recua_rapido_h                  
goto inicio


frente_bola_rap_1: 'Limite até onde atáca a bola
low 7
PULSOUT 7, 5   
PULSIN 4, 1, w6    'Ultra Sons e escreve na w6 a distancia da baliza
if w6>400 then parado_acerto'pos_centro_2
if w6<401 then frente_bola_rap
goto inicio


pronto_a_def:
if pin7=0 and pin6=0 and pin5=0 and pin3=0 and pin2=0 then nocentro'centro
if pin7=0 and pin6=1 and pin5=0 and pin3=0 and pin2=0 then nocentro'centro
if pin7=0 and pin6=0 and pin5=0 and pin3=1 and pin2=0 then nocentro'centro

if pin7=0 and pin6=0 and pin5=1 and pin3=0 and pin2=0 then parado_acerto
if pin7=0 and pin6=1 and pin5=1 and pin3=1 and pin2=0 then frente_bola_rap_1  
if pin7=0 and pin6=1 and pin5=0 and pin3=1 and pin2=0 then frente_bola_rap_1

if pin7=1 and pin6=1 and pin5=0 and pin3=0 and pin2=0 then lado_esquerdo_rap
if pin7=1 and pin6=0 and pin5=0 and pin3=0 and pin2=0 then lado_esquerdo_rap
if pin7=0 and pin6=0 and pin5=0 and pin3=1 and pin2=1 then lado_direito_rap
if pin7=0 and pin6=0 and pin5=0 and pin3=0 and pin2=1 then lado_direito_rap

if pin7=0 and pin6=0 and pin5=1 and pin3=0 and pin2=1 then recua
if pin7=0 and pin6=0 and pin5=1 and pin3=1 and pin2=1 then recua_oblq_direita
if pin7=1 and pin6=0 and pin5=1 and pin3=0 and pin2=0 then recua
if pin7=1 and pin6=1 and pin5=1 and pin3=0 and pin2=0 then recua_oblq_esqerda
goto inicio



nocentro:
low 5
PULSOUT 5, 5   'Ultra Sons e escreve na w8-lado direito
PULSIN 0, 1, w8
if w8>484 and w8<505 then centro
if w8>504  and w8<551 then lado_direito'_k 
if w8>550 then lado_direito'_k                                     'lado_direito_rap2  
if w8<485 then lado_esquerdo_regula
goto inicio

lado_esquerdo_regula:
low 6          
PULSOUT 6, 5   'Ultra Sons e escreve na w7-lado esquerdo
PULSIN 1, 1, w7
if w7>470 and w7<505 then centro '229
if w7>504 and w7<551 then lado_esquerdo'_k  
if w7>550 then lado_esquerdo'_k                                      'lado_esquerdo_rap2 
if w7<471 then frente_bola_acerto                           
goto inicio                   

centro:
low 7
PULSOUT 7, 5   'Ultra Sons e escreve na w6 a distancia da baliza
PULSIN 4, 1, w6
if w6>79 and w6<100  then parado 
if w6>99 and w6<130 then recua_lento'_h '150  
if w6>129 and w6<170 then recua'_h                        
if w6>169            then recua'_h'_rap                      
if w6<80            then frente_bola_h'_acerto     
goto inicio


frente_bola_acerto:
low 5
PULSOUT 5, 5   'Ultra Sons e escreve na w8-lado direito
PULSIN 0, 1, w8
low 6
PULSOUT 6, 5   'Ultra Sons e escreve na w7-lado esquerdo
PULSIN 1, 1, w7  
if W7<271 and W8<271 then frente_bola'_k
if W7>270 and W8>270 then frente_bola'_h
if W7>270 and W8<271 then lado_esquerdo'_k'frente_oblq_esquerda_h
if W7<271 and W8>270 then lado_direito'_k'frente_oblq_direita_h
goto inicio



'#######################################################

parado: 
readadc 1, b20
if b20>149 then linha_x1'linha_x
if b20<150 then parado_h 
goto inicio

parado_h:
low portc 0 'motor4
low portc 5
low portc 6  'motor3
low portc 7
low 0        'motor2
low 1
low 2        'motor1
low 3
pwmout portc 1, 10, 00
pwmout portc 2, 10, 00
goto inicio


frente_bola:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then frente_bola_h 
goto inicio

frente_bola_h:
low portc 0
high portc 5
low portc 6
high portc 7
low 0
high 1
low 2
high 3
pwmout portc 1, 10, 30
pwmout portc 2, 10, 20 'acerto 
goto inicio

frente_bola_rap:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then frente_bola_rap_h 
goto inicio

frente_bola_rap_h:
low portc 0
high portc 5
low portc 6
high portc 7
low 0
high 1
low 2
high 3
pwmout portc 1, 10, 35'45   alterado
pwmout portc 2, 10, 30'45
goto inicio

recua:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then recua_h 
goto inicio

recua_h:
high portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
high 2
low 3
pwmout portc 1, 10, 23
pwmout portc 2, 10, 26
goto inicio

recua_rapido:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then recua_rapido_h 
goto inicio

recua_rapido_h:
high portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
high 2
low 3
pwmout portc 1, 10, 27'42 
pwmout portc 2, 10, 33'45
goto inicio

recua_lento:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then recua_lento_h 
goto inicio

recua_lento_h:
high portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
high 2
low 3
pwmout portc 1, 10, 18'15
pwmout portc 2, 10, 18'15
goto inicio



'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

lado_esquerdo:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then lado_esquerdo_h 
goto inicio

lado_esquerdo_h:
let b2=0
let b3=b3+1
if b3>25 then lado_esq_flag 
if b3<26 then lado_esquerdo_k 
goto inicio


lado_esq_flag:
low 4 '«««««««««««««««««
high portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10,20
pwmout portc 2, 10,20
flag=1
goto inicio

lado_esquerdo_k:
high portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10,20
pwmout portc 2, 10,20
goto inicio

lado_direito:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then lado_direito_h 
goto inicio

lado_direito_h:
let b3=0
let b2=b2+1
if b2>25 then lado_dir_flag 
if b2<26 then lado_direito_k 
goto inicio

lado_dir_flag:
high 4 '«««««««««««««««««
low portc 0
high portc 5
high portc 6
low portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10,20
pwmout portc 2, 10,20
flag=2
goto inicio

lado_direito_k:
low portc 0
high portc 5
high portc 6
low portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10,20
pwmout portc 2, 10,20
goto inicio


lado_esquerdo_rap:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then lado_esquerdo_rap_h 
goto inicio

lado_esquerdo_rap_h:
let b2=0
let b3=b3+1
if b3>16 then lado_esq_rat_flag 
if b3<17 then lado_esq_rap_conta 
goto inicio

lado_esq_rap_conta:
high portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10,35'50'30'50  'rodas trazeiras        velocidade  max35
pwmout portc 2, 10,35'50'30'50  'rodas da frente
goto inicio

lado_esq_rat_flag:
low 4 '«««««««««««««««««
high portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10,35'50'30'50  'rodas trazeiras        velocidade  max35
pwmout portc 2, 10,35'50'30'50  'rodas da frente
flag=1
goto inicio

lado_esquerdo_rap_le:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then lado_esquerdo_rap_le_h 
goto inicio

lado_esquerdo_rap_le_h:
let b2=0
let b3=b3+1
if b3>16 then lado_esq_rap_le_flag 
if b3<17 then lado_esq_rap_le_conta 
goto inicio

lado_esq_rap_le_conta:
high portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10,26  'rodas trazeiras        velocidade  max35
pwmout portc 2, 10,26  'rodas da frente
goto inicio


lado_esq_rap_le_flag:
low 4 '«««««««««««««««««
high portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10,26  'rodas trazeiras        velocidade  max35
pwmout portc 2, 10,26  'rodas da frente
flag=1
goto inicio



lado_direito_rap:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then lado_direito_rap_h 
goto inicio

lado_direito_rap_h:
let b3=0
let b2=b2+1
if b2>16 then lado_dir_rap_flag 
if b2<17 then lado_direito_rap_conta 
goto inicio

lado_direito_rap_conta:
low portc 0
high portc 5
high portc 6
low portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10,30'30'30'30 
pwmout portc 2, 10,35'50'30'50
goto inicio

lado_dir_rap_flag:
high 4 '«««««««««««««««««
low portc 0
high portc 5
high portc 6
low portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10,30'30'30'30 
pwmout portc 2, 10,35'50'30'50
flag=2
goto inicio

lado_direito_rap_le:
readadc 1, b20
if b20>149 then linha_x1'lado_esquerdo_rap_xx
if b20<150 then lado_direito_rap_le_h 
goto inicio

lado_direito_rap_le_h:
let b3=0
let b2=b2+1
if b2>16 then lado_dir_rap_le_flag 
if b2<17 then lado_direito_rap_le_conta 
goto inicio

lado_direito_rap_le_conta:
low portc 0
high portc 5
high portc 6
low portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10,26                 
pwmout portc 2, 10,26
goto inicio

lado_dir_rap_le_flag:
high 4 '«««««««««««««««««
low portc 0
high portc 5
high portc 6
low portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10,26                 
pwmout portc 2, 10,26
flag=2
goto inicio
'»»»»»»»»


'»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»
recua_oblq_direita:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then recua_oblq_direita_h 
goto inicio

recua_oblq_direita_h:
let b3=0
let b2=b2+1
if b2>16 then recua_oblq_dir_flag 
if b2<17 then recua_oblq_dir_conta 
goto inicio

recua_oblq_dir_conta:
low portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
low 2
low 3
pwmout portc 1, 10, 40'  alterado
pwmout portc 2, 10, 40'
goto inicio

recua_oblq_dir_flag:
high 4 '«««««««««««««««««
low portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
low 2
low 3
pwmout portc 1, 10, 40'  alterado
pwmout portc 2, 10, 40'
flag=2
goto inicio

recua_oblq_direita_le:
low portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
low 2
low 3
pwmout portc 1, 10, 22
pwmout portc 2, 10, 22
goto inicio



recua_oblq_esqerda:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then recua_oblq_esqerda_h 
goto inicio

recua_oblq_esqerda_h:
let b2=0
let b3=b3+1
if b3>16 then recua_oblq_esq_flag 
if b3<17 then recua_oblq_esq_conta 
goto inicio

recua_oblq_esq_conta:
high portc 0
low portc 5
low portc 6
low portc 7
low 0
low 1
high 2
low 3
pwmout portc 1, 10, 40
pwmout portc 2, 10, 40
goto inicio

recua_oblq_esq_flag:
low 4 '«««««««««««««««««
high portc 0
low portc 5
low portc 6
low portc 7
low 0
low 1
high 2
low 3
pwmout portc 1, 10, 40  
pwmout portc 2, 10, 40
flag=1
goto inicio

recua_oblq_esqerda_le:
high portc 0
low portc 5
low portc 6
low portc 7
low 0
low 1
high 2
low 3
pwmout portc 1, 10, 22
pwmout portc 2, 10, 22
goto inicio


frente_oblq_esquerda:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then frente_oblq_esquerda_h 
goto inicio

frente_oblq_esquerda_h:
let b2=0
let b3=b3+1
if b3>16 then frente_oblq_esq_flag 
if b3<17 then esq_frent_oblq_k 
goto inicio


frente_oblq_esq_flag:
low 4 '«««««««««««««««««
low portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
low 2
low 3
pwmout portc 1, 10, 30
pwmout portc 2, 10, 30
flag=1
goto inicio

esq_frent_oblq_k:
low portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
low 2
low 3
pwmout portc 1, 10, 30
pwmout portc 2, 10, 30
goto inicio


frente_oblq_direita:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then frente_oblq_direita_h 
goto inicio

frente_oblq_direita_h:
let b3=0
let b2=b2+1
if b2>16 then frente_oblq_dir_flag 
if b2<17 then dir_frent_oblq_k 
goto inicio

frente_oblq_dir_flag:
high 4 '«««««««««««««««««
low portc 0
high portc 5
low portc 6
low portc 7
low 0
low 1
low 2
high 3
pwmout portc 1, 10, 30
pwmout portc 2, 10, 30
flag=2
goto inicio

dir_frent_oblq_k:
low portc 0
high portc 5
low portc 6
low portc 7
low 0
low 1
low 2
high 3
pwmout portc 1, 10, 30
pwmout portc 2, 10, 30
goto inicio

'«««««««««««««««««««««««««««««««««««««««««««««««

rodar_esquerda:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then rodar_esquerda_h 
goto inicio

rodar_esquerda_h:
high portc 0
low portc 5
low portc 6
high portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10, 20
pwmout portc 2, 10, 20
goto inicio

rodar_direita:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then rodar_direita_h 
goto inicio

rodar_direita_h:
low portc 0
high portc 5
high portc 6
low portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10, 20
pwmout portc 2, 10, 20
goto inicio


rodar_esquerda_lento:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then rodar_esquerda_lento_h 
goto inicio

rodar_esquerda_lento_h:
high portc 0
low portc 5
low portc 6
high portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10, 16
pwmout portc 2, 10, 16
goto inicio

rodar_direita_lento:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then rodar_direita_lento_h 
goto inicio

rodar_direita_lento_h:
low portc 0
high portc 5
high portc 6
low portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10, 16
pwmout portc 2, 10, 16
goto inicio

rodar_esquerda_lento_1:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then rodar_esquerda_lento_1_h 
goto inicio

rodar_esquerda_lento_1_h:
high portc 0
low portc 5
low portc 6
high portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10, 10'12   
pwmout portc 2, 10, 10'12
goto inicio

rodar_direita_lento_1:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then rodar_direita_lento_1_h 
goto inicio

rodar_direita_lento_1_h:
low portc 0
high portc 5
high portc 6
low portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10, 10'12'10  
pwmout portc 2, 10, 10'12'10
goto inicio

rodar_esquerda_lento_2:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then rodar_esquerda_lento_2_h 
goto inicio

rodar_esquerda_lento_2_h:
high portc 0
low portc 5
low portc 6
high portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10, 12
pwmout portc 2, 10, 12
goto inicio

rodar_direita_lento_2:
readadc 1, b20
if b20>149 then linha_x1
if b20<150 then rodar_direita_lento_2_h 
goto inicio

rodar_direita_lento_2_h:
low portc 0
high portc 5
high portc 6
low portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10, 12
pwmout portc 2, 10, 12
goto inicio


'LINHA           ========================
'#############################################
'##############################################
'#################################################
'################################################'####
'###################################################


linha_x1:
if flag=1 then lado_direito_rap_xx
if flag=2 then lado_esquerdo_rap_xx
goto inicio 



lado_direito_rap_xx:
low 7
PULSOUT 7, 3   'Ultra Sons e escreve na w6 a distancia de trás
PULSIN 4, 1, w6
if w6<221  then dir_frent_oblq_xxx2'frente_bola_afasta_x
if w6>220  then lado_direito_rap_xx3'_1
goto inicio


lado_direito_rap_xx3:
i2cslave $C0,i2cfast,i2cbyte	' Define i2c slave address for the CMPS03
readi2c 0,(b1)		' ler CMPS03 Software Revision
readi2c 1,(b5)
if b5<5  then lado_direito_rap_xx4
if b5>4  and b5<127 then dir_frent_oblq_xxx2
if b5>126 then lado_direito_rap_xx4
goto inicio

lado_direito_rap_xx4:                                   
low portc 0
high portc 5
high portc 6
low portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10,25'30'30'30'30  'acerto      alterado
pwmout portc 2, 10,25'30'50'30'50
pause 500
goto parado_w

dir_frent_oblq_xxx2:
low portc 0
high portc 5
low portc 6
low portc 7
low 0
low 1
low 2
high 3
pwmout portc 1, 10, 30
pwmout portc 2, 10, 30
pause 600
goto parado_w



lado_esquerdo_rap_xx:
low 7
PULSOUT 7, 3   'Ultra Sons e escreve na w6 a distancia de trás
PULSIN 4, 1, w6
if w6<221  then esq_frent_oblq_xxx2'frente_bola_afasta_x
if w6>220  then lado_esquerdo_rap_xx3'_1
goto inicio



lado_esquerdo_rap_xx3:
i2cslave $C0,i2cfast,i2cbyte	' Define i2c slave address for the CMPS03
readi2c 0,(b1)		' ler CMPS03 Software Revision
readi2c 1,(b5)
if b5<127 then lado_esquerdo_rap_xx4
if b5>126 and b5<251 then esq_frent_oblq_xxx2
if b5>250 then lado_esquerdo_rap_xx4
goto inicio


lado_esquerdo_rap_xx4:
high portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10,25'30'50'30'50  'rodas trazeiras        alterado
pwmout portc 2, 10,25'30'50'30'50  'rodas da frente
pause 500
goto parado_w


esq_frent_oblq_xxx2:
low portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
low 2
low 3
pwmout portc 1, 10, 30
pwmout portc 2, 10, 30
pause 600
goto parado_w


parado_w:
low portc 0
low portc 5
low portc 6
low portc 7
low 0
low 1
low 2
low 3
pause 100
goto inicio