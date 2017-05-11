'ALTERAR VELOCIDADE na bola 527
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
if b5>1  and b5<124 then desliga_led_verde
if b5>125  and b5<130 then virado_contrario
if b5>129  and b5<255 then desliga_led_verde
if b5>254 then liga_led_verde
goto iniciar

liga_led_verde:
high 4
goto iniciar

desliga_led_verde:
low 4
goto iniciar

virado_contrario:
high 4
pause 50
low 4
pause 70
goto iniciar

'»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»
'##################################################################
'»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»
      
inicio:
low 7
PULSOUT 7, 1   'pino B7 Ultra Sons e escreve na w1
PULSIN 4, 1, w1
if w1<22 then frente_baliza
if w1>21 and w1<29 then frente_bola_inicio_1a              'alteração
if w1>28 then frente_bola_inicio
goto inicio


frente_bola_inicio:
if pin3=1 then linha
if pin3=0 then frente_bola_inicio_1
goto inicio

frente_bola_inicio_1a:                                       'alteração
if pin7=0 and pin6=0 and pin5=0 then parado_1'parado
if pin7=0 and pin6=1 and pin5=0 then frente
if pin7=1 and pin6=0 and pin5=0 then esquerdo_perto
if pin7=0 and pin6=0 and pin5=1 then direito_perto
if pin7=1 and pin6=1 and pin5=0 then esquerda_r
if pin7=0 and pin6=1 and pin5=1 then direita_r
goto inicio


frente_bola_inicio_1:
if pin7=0 and pin6=0 and pin5=0 then parado_1'parado
if pin7=0 and pin6=1 and pin5=0 then frente
if pin7=1 and pin6=0 and pin5=0 then esquerda
if pin7=0 and pin6=0 and pin5=1 then direita
if pin7=1 and pin6=1 and pin5=0 then esquerda_r
if pin7=0 and pin6=1 and pin5=1 then direita_r
goto inicio


'#######################################################

frente:
if w1>28 and w1<220 then posicionase   '200  120    '????????????????????????????????????????????????????
'if w1>199 then frente_bola1111             '119
if w1>219 and w1< 250 then frente_bola_xx_lento 'if w1>219 and w1< 260 then frente_bola_xx_lento 
if w1>249 then frente_bola1111'if w1>259 then frente_bola1111 
goto inicio


posicionase:'interroga se esta do lado da frente ou ao contrario
i2cslave $C0,i2cfast,i2cbyte	' 0,63,127,192 valores de tabela  
readi2c 0,(b14)	            
readi2c 1,(b15)
if b15<45 then frente_bola_1  '45
if b15>44  and b15<85 then desviar_lado_direito_1111'desv_lado_dir_interrog   45- 85
if b15>84 and b15<127 then desv_interrg_lad_dir  '84 - 127
if b15>126 and b15<170 then desv_interrg_lad_esq '126 - 170  
if b15>169 and b15<210 then desviar_lado_esquerdo_1111'desv_lado_esq_interrog  169 - 210
if b15>209 then frente_bola_1	  '209	
goto inicio

frente_bola_1:
if w1<35 then frente_bola_dribulador
if w1>34 then frente_bola_xx_lento'frente_bola
goto inicio
		

frente_bola_dribulador:
if pin3=1 then linha
if pin3=0 then frente_bola_dribulador_1
goto inicio

frente_bola_dribulador_1:
low portc 0
high portc 5
low portc 6
high portc 7
low 0
high 1
low 2
high 3
high 4 'liga o dribulador
pwmout portc 1, 10, 37  '32  
pwmout portc 2, 10, 37  '32
goto inicio

frente_bola:
low portc 0
high portc 5
low portc 6
high portc 7
low 0
high 1
low 2
high 3
low 4' desliga o dribulador
pwmout portc 1, 10,32'30'28'26'40'motores do lado direito   xxxxxxxxxxxxxxx   AFINAÇÃO VELOCIDADE
pwmout portc 2, 10,32'30'32'29'50'motores do lado esquerdo           (para velocidade maior tem de ser
goto inicio                                                    ' alterado velocidade no contorna
                                                              'esquerda_obliq_r:direita_obliq_r: 
frente_bolalento:
low portc 0
high portc 5
low portc 6
high portc 7
low 0
high 1
low 2
high 3
low 4' desliga o dribulador
pwmout portc 1, 10,24'26'40motores do lado direito
pwmout portc 2, 10,24'26'50'motores do lado esquerdo        
goto inicio


esquerdo_perto:                                 'alteração
if pin3=1 then linha
if pin3=0 then esquerda_obliq_frente_perto'esquerdo_perto_1
goto inicio

direito_perto:                                  'alteração
if pin3=1 then linha
if pin3=0 then direita_obliq_frente_perto'direito_perto_1
goto inicio

direito_perto_1: '
low portc 0
high portc 5
low portc 6
low portc 7
low 0
low 1
low 2
high 3
low 4 ' dribulador
pwmout portc 1, 10, 35'30    'motores do lado direito
pwmout portc 2, 10, 15'30    'motores do lado esquerdo 
goto inicio


esquerdo_perto_1: '
low portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
low 2
low 3
low 4 ' dribulador
pwmout portc 1, 10, 13'30    'motores do lado direito
pwmout portc 2, 10, 35'30     'motores do lado esquerdo 
goto inicio

direita_obliq_frente_perto:
low portc 0
high portc 5
low portc 6
low portc 7
low 0
low 1
low 2
high 3
low 4 ' dribulador
pwmout portc 1, 10, 26'30    'motores do lado direito             alteração
pwmout portc 2, 10, 26'30    'motores do lado esquerdo 
goto inicio


esquerda_obliq_frente_perto:
low portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
low 2
low 3
low 4 ' dribulador
pwmout portc 1, 10, 26'30    'motores do lado direito                alteração
pwmout portc 2, 10, 26'30     'motores do lado esquerdo 
goto inicio



frente_bola1111: 
if pin3=1 then linha
if pin3=0 then frente_bola  ' frente_bola_5
goto inicio


'frente_bola_5:
'if b24=1 then parado
'if b24=0 then frente_bola
'goto inicio

frente_bola_xx_lento: 
if pin3=1 then linha
if pin3=0 then frente_bolalento 'frente_bola_6
goto inicio


'frente_bola_6:
'if b24=1 then parado
'if b24=0 then frente_bolalento
'goto inicio

'#####################
'######################


direita:
if pin3=1 then linha
if pin3=0 then direita1111
goto inicio

direita1111:
'let b24=0
low portc 0
high portc 5
high portc 6
low portc 7
low 0
high 1
high 2
low 3
low 4  'desliga o dribulador
pwmout portc 1, 10,15
pwmout portc 2, 10,15
goto inicio

esquerda:
if pin3=1 then linha
if pin3=0 then esquerda1111
goto inicio

esquerda1111:
'let b24=0
high portc 0
low portc 5
low portc 6
high portc 7
high 0
low 1
low 2
high 3
low 4  'desliga o dribulador
pwmout portc 1, 10,15
pwmout portc 2, 10,15
goto inicio

direita_r:
if pin3=1 then linha
if pin3=0 then direita_r1111
goto inicio

direita_r1111:
'let b24=0
low portc 0
high portc 5
high portc 6
low portc 7
low 0
high 1
high 2
low 3
low 4  'desliga o dribulador
pwmout portc 1, 10,26 '22
pwmout portc 2, 10,26 '22
goto inicio

esquerda_r:
if pin3=1 then linha
if pin3=0 then esquerda_r1111
goto inicio

esquerda_r1111:
'let b24=0
high portc 0
low portc 5
low portc 6
high portc 7
high 0
low 1
low 2
high 3
low 4  'desliga o dribulador
pwmout portc 1, 10,26'22
pwmout portc 2, 10,26'22
goto inicio


parado_1:
if pin3=1 then linha
if pin3=0 then parado
goto inicio

parado: 
low portc 0
low portc 5
low portc 6
low portc 7
low 0
low 1
low 2
low 3
low 4  'desliga dribulador
pwmout portc 1, 10, 00
pwmout portc 2, 10, 00
goto inicio


'######################################################
'########################################################
'#####################################################################

'#################    QUANDO SE DIRIGE PARA A BOLA E TEM DE A CONTORNAR   ###################

desv_interrg_lad_esq:
low 5    
PULSOUT 5, 2                               'lado direito 
PULSIN 0, 1, w6
if w6>550 then desviar_lado_direito_1111     'antigamente 240
if w6<551 then desviar_lado_esquerdo_1111  
goto inicio

desv_interrg_lad_dir:
low 6
PULSOUT 6, 5                          'lado esquerdo
PULSIN 1, 1, w4
if w4>550 then desviar_lado_esquerdo_1111'desviar_lado_direito_1111    'alteração 
if w4<551 then desviar_lado_direito_1111'desviar_lado_esquerdo_1111  
goto inicio

desviar_lado_direito_1111:
if w1<120 then desviar_lado_direito_2
if w1>119 then desviar_lado_direito
goto inicio

desviar_lado_esquerdo_1111:
if w1<120 then desviar_lado_esquerdo_2
if w1>119 then desviar_lado_esquerdo
goto inicio


desviar_lado_esquerdo:
for b20= 1 to 3'2
gosub lado_esquerdo
next b20
for b20= 1 to 30'20          '40
gosub esquerda_obliq_r_1
next b20
goto inicio

desviar_lado_esquerdo_2:
for b20= 1 to 1
gosub lado_esquerdo
next b20
for b20= 1 to 10          '40
gosub esquerda_obliq_r_1
next b20
goto inicio

desviar_lado_direito:
for b20= 1 to 3'2
gosub lado_direito
next b20
for b20= 1 to 30'20         '40
gosub direita_obliq_r_1
next b20
goto inicio

desviar_lado_direito_2:
for b20= 1 to 1
gosub lado_direito
next b20
for b20= 1 to 10          '40
gosub direita_obliq_r_1
next b20
goto inicio


lado_esquerdo:
if pin3=1 then linha'lado_direito_xx_k'lado_direito_xx_2
if pin3=0 then lado_esquerdo_1
return

lado_esquerdo_1:
high portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10,30 '??????????????????????????
pwmout portc 2, 10,30
return

lado_direito:
if pin3=1 then linha'lado_esquerdo_xx_k'lado_esquerdo_xx_2
if pin3=0 then lado_direito_1
return

lado_direito_1:
low portc 0
high portc 5
high portc 6
low portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10, 30    '??????????????
pwmout portc 2, 10, 30
return


direita_obliq_r_1:
if pin3=1 then linha'lado_esquerdo_xx_k'lado_esquerdo_xx_2
if pin3=0 then direita_obliq_r
return

direita_obliq_r:
low portc 0
high portc 5
low portc 6
low portc 7
low 0
low 1
low 2
high 3
low 4 ' dribulador
pwmout portc 1, 10, 35'30    'motores do lado direito             alteração
pwmout portc 2, 10, 20'30    'motores do lado esquerdo 
return

esquerda_obliq_r_1:
if pin3=1 then linha'lado_direito_xx_k'lado_direito_xx_2
if pin3=0 then esquerda_obliq_r
return

esquerda_obliq_r:
low portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
low 2
low 3
low 4 ' dribulador
pwmout portc 1, 10, 18'30    'motores do lado direito                alteração
pwmout portc 2, 10, 35'30     'motores do lado esquerdo 
return
'###################################


'#######################################################################################


frente_baliza:
i2cslave $C0,i2cfast,i2cbyte	' Define i2c slave address for the CMPS03
readi2c 0,(b6)	                	' ler CMPS03 Software Revision
readi2c 1,(b5)   ' ATACA A "0"		
if b5<12 then frente_bola_baliza
if b5>11 and b5<128 then rodar_esquerda_lento
if b5>127 and b5<244 then rodar_direita_lento
if b5>243 then frente_bola_baliza
goto inicio


rodar_esquerda_lento:
if pin3=1 then linha
if pin3=0 then rodar_esquerda_lento_1
goto inicio

rodar_esquerda_lento_1:
high portc 0
low portc 5
low portc 6
high portc 7
high 0
low 1
low 2
high 3
high 4  'liga o dribulador
pwmout portc 1, 10, 15
pwmout portc 2, 10, 15
goto inicio

rodar_direita_lento:
if pin3=1 then linha
if pin3=0 then rodar_direita_lento_1
goto inicio

rodar_direita_lento_1:
low portc 0
high portc 5
high portc 6
low portc 7
low 0
high 1
high 2
low 3
high 4  'liga o dribulador
pwmout portc 1, 10, 15
pwmout portc 2, 10, 15
goto inicio

'#######################################################################

frente_bola_baliza:
low 6
PULSOUT 6, 5   
PULSIN 1, 1, w4  ' esquerdo
pause 5
low 5
PULSOUT 5, 5   
PULSIN 0, 1, w6
if w4<501 and w6>500 then direita_obliq           'antigamente 250
if w4>500 and w6<501 then esquerda_obliq
if w4>500 and w6>500 then frente_bola_baliza_frente
if w4<501 and w6<501 then frente_bola_baliza_frente'
goto inicio


frente_bola_baliza_frente:                               
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b6)		
readi2c 1,(b5)
if b5<6 then frente_frente_bola
if b5>5 and b5<128 then frente_frente_bola_esquerdo 
if b5>127 and b5<250 then frente_frente_bola_direito 
if b5>249 then frente_frente_bola	
goto inicio

frente_frente_bola_fr:
low 7
PULSOUT 7, 1   'pino B7 Ultra Sons e escreve na w1
PULSIN 4, 1, w1
if w1<22 then frente_bola_baliza_frente
goto inicio


frente_frente_bola:
if pin3=1 then linha
if pin3=0 then frente_frente_bola_1
goto inicio

frente_frente_bola_1:
low portc 0
high portc 5
low portc 6
high portc 7
low 0
high 1
low 2
high 3
high 4 'liga o dribulador
pwmout portc 1, 10, 30'34' 'motores do lado direito     'VELOCIDADE COM BOLA
pwmout portc 2, 10, 31'35' 'motores do lado esquerdo     
goto frente_frente_bola_fr'inicio

frente_frente_bola_esquerdo:
if pin3=1 then linha
if pin3=0 then frente_frente_bola_esquerdo_1
goto inicio

frente_frente_bola_esquerdo_1:
low portc 0
high portc 5
low portc 6
high portc 7
low 0
high 1
low 2
high 3
high 4 'liga o dribulador
pwmout portc 1, 10, 35 'motores do lado direito
pwmout portc 2, 10, 18 'motores do lado esquerdo     
goto frente_frente_bola_fr'inicio


frente_frente_bola_direito:
if pin3=1 then linha
if pin3=0 then frente_frente_bola_direito_1
goto inicio

frente_frente_bola_direito_1:
low portc 0
high portc 5
low portc 6
high portc 7
low 0
high 1
low 2
high 3
high 4 'liga o dribulador
pwmout portc 1, 10, 18 'motores do lado direito
pwmout portc 2, 10, 37 'motores do lado esquerdo     
goto frente_frente_bola_fr'inicio

'««««««««««««««««««««««««

direita_obliq:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b6)		
readi2c 1,(b5)
if b5<6 then direita_obliq_dir
if b5>5 and b5<12 then direita_obliq_frente:
if b5>5 and b5<128 then direita_obliq_esq
if b5>127 and b5<250 then direita_obliq_dir
goto inicio

esquerda_obliq:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b6)		
readi2c 1,(b5)
if b5<128 then esquerda_obliq_esq
if b5>127 and b5<243 then esquerda_obliq_dir
if b5>242 and b5<249 then esquerda_obliq_frente
if b5>248 then esquerda_obliq_esq
goto inicio


direita_obliq_frente:
if pin3=1 then linha
if pin3=0 then direita_obliq_frente_1
goto inicio

direita_obliq_frente_1:
low portc 0
high portc 5
low portc 6
low portc 7
low 0
high 1 'low 1
low 2
high 3
high 4 'liga o dribulador
pwmout portc 1, 10,50        'motores do lado direito
pwmout portc 2, 10,30   'motores do lado esquerdo  (os 2 motores a rodar lento)
goto inicio

direita_obliq_dir:
if pin3=1 then linha
if pin3=0 then direita_obliq_dir_1
goto inicio

direita_obliq_dir_1:
low portc 0
high portc 5
low portc 6
low portc 7
low 0
high 1 'low 1
low 2
high 3
high 4 'liga o dribulador
pwmout portc 1, 10,30        'motores do lado direito
pwmout portc 2, 10,45   'motores do lado esquerdo  (os 2 motores a rodar lento)
goto inicio

direita_obliq_esq:
if pin3=1 then linha
if pin3=0 then direita_obliq_esq_1
goto inicio

direita_obliq_esq_1:
low portc 0
high portc 5
low portc 6
low portc 7
low 0
high 1 'low 1
low 2
high 3
high 4 'liga o dribulador
pwmout portc 1, 10,50        'motores do lado direito
pwmout portc 2, 10,20   'motores do lado esquerdo  (os 2 motores a rodar lento)
goto inicio

esquerda_obliq_frente:
if pin3=1 then linha
if pin3=0 then esquerda_obliq_frente_1
goto inicio

esquerda_obliq_frente_1:
low portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
low 2
high 3  'low 3
high 4 'liga o dribulador
pwmout portc 1, 10,30  'motores do lado direito  (os 2 motores a rodar lento)
pwmout portc 2, 10,50         'motores do lado esquerdo
goto inicio

esquerda_obliq_esq:
if pin3=1 then linha
if pin3=0 then esquerda_obliq_esq_1
goto inicio

esquerda_obliq_esq_1:
low portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
low 2
high 3  'low 3
high 4 'liga o dribulador
pwmout portc 1, 10,45  'motores do lado direito  (os 2 motores a rodar lento)
pwmout portc 2, 10,30         'motores do lado esquerdo
goto inicio

esquerda_obliq_dir:
if pin3=1 then linha
if pin3=0 then esquerda_obliq_dir_1
goto inicio

esquerda_obliq_dir_1:
low portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
low 2
high 3  'low 3
high 4 'liga o dribulador
pwmout portc 1, 10,20  'motores do lado direito  (os 2 motores a rodar lento)
pwmout portc 2, 10,50         'motores do lado esquerdo
goto inicio

'##############LINHA###########LINHA############LINHA##############LINHA############
'##############LINHA###########LINHA############LINHA##############LINHA############
'##############LINHA###########LINHA############LINHA##############LINHA############
'##############LINHA###########LINHA############LINHA##############LINHA############
'LINHA######LINHA#########LINHA##########LINHA##########LINHA##########LINHA##############
'##############LINHA###########LINHA############LINHA##############LINHA############

linha:
'let b24=1
low portc 0
low portc 5
low portc 6
low portc 7
low 0
low 1
low 2
low 3
high 4 'liga o dribulador
goto linha_h

linha_h:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		
readi2c 1,(b5)		' escreve a posição na B5 (0-255 for full circle) ATACA A "0"				
if b5<11 then  parado_linha_xx
if b5>10 and b5<21 then roda_esquerda_linha_lento'
if b5>20 and b5<64 then roda_esquerda_linha'      
if b5>63 and b5<108 then roda_direita_linha'
if b5>107 and b5<117 then roda_direita_linha_lento'     
if b5>116 and b5<138 then parado_linha_virado
if b5>137 and b5<147 then roda_esquerda_linha_lento'
if b5>146 and b5<191 then roda_esquerda_linha'        
if b5>190 and b5<235 then roda_direita_linha'
if b5>134 and b5<245 then roda_direita_linha_lento'                                                                                                                                                                                                                                                            
if b5>244 then parado_linha_xx
goto inicio

roda_esquerda_linha:
high portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
high 2
low 3
high 4 'liga o dribulador
pwmout portc 1,10,10
pwmout portc 2,10,24
goto linha_h

roda_esquerda_linha_lento:
high portc 0
low portc 5
low portc 6
high portc 7
high 0
low 1
low 2
high 3
high 4  ' dribulador
pwmout portc 1, 10,15
pwmout portc 2, 10,15
goto linha_h


roda_direita_linha:
high portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
high 2
low 3
high 4 'liga o dribulador
pwmout portc 1,10,24
pwmout portc 2,10,10
goto linha_h

roda_direita_linha_lento:
low portc 0
high portc 5
high portc 6
low portc 7
low 0
high 1
high 2
low 3
high 4  ' dribulador
pwmout portc 1, 10,15
pwmout portc 2, 10,15
goto linha_h

parado_linha_xx:
low portc 0
low portc 5
low portc 6
low portc 7
low 0
low 1
low 2
low 3
low 4 'desliga o dribulador
goto linha_xx_1x

linha_xx_1x:
i2cslave $E0,i2cfast,i2cbyte	
i2cwrite 0,(81)	
pause 40			
i2cread 2,(b11, b10)	' Read in  high byte and low byte (escreve na W5)
low 7
PULSOUT 7, 1   
PULSIN 4, 1, w1
if W1<260 and W5<61 then parado_linha
if W1>260 and W5>60 then linha_xx_1          
if W1>260 and W5<61 then linha_xx_frente
if W1<261 and W5>60 then linha_xx_1
goto inicio


parado_linha:
if W1<23 then linha_xx_1
if W1>22 then parado_linha_xx
goto inicio


linha_xx_1:
low 5
PULSOUT 5, 5   'Ultra Sons e escreve na w6-lado direito
PULSIN 0, 1, w6
pause 20
low 6
PULSOUT 6, 5   'Ultra Sons e escreve na w4-lado esquerdo
PULSIN 1, 1, w4                                                 
if W4<260 and W6<260 then recuar300a
if W4>260 and W6>260 then inicio
if W4>260 and W6<261 then recua_oblq_esqerda_x 
if W4<261 and W6>260 then recua_oblq_direita_x
goto inicio

recuar300a:
i2cslave $C0,i2cfast,i2cbyte	
readi2c 0,(b1)		
readi2c 1,(b5)		' escreve a posição na B5 (0-255 for full circle) ATACA A "0"				
if b5<6 then  recuar300
if b5>5 and b5<128 then rodar_esqerda_k
if b5>127and b5<250 then rodar_direita_k                                                                                                                                                                                                                                                          
if b5>249 then recuar300
goto inicio

recuar300:
high portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
high 2
low 3
high 4 'liga o dribulador
pwmout portc 1,10,22
pwmout portc 2,10,26
goto linha_xx_1

rodar_esqerda_k:
high portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
high 2
low 3
high 4 'liga o dribulador
pwmout portc 1,10,10
pwmout portc 2,10,24
goto linha_xx_1

rodar_direita_k:
high portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
high 2
low 3
high 4 'liga o dribulador
pwmout portc 1,10,24
pwmout portc 2,10,10
goto linha_xx_1

linha_xx_frente:
low 5
PULSOUT 5, 5   'Ultra Sons e escreve na w6-lado direito
PULSIN 0, 1, w6
pause 20
low 6
PULSOUT 6, 5   'Ultra Sons e escreve na w4-lado esquerdo
PULSIN 1, 1, w4                                                 
if W4<260 and W6<260 then frente300  
if W4>260 and W6>260 then inicio
if W4>260 and W6<261 then frente_oblq_esqerda_x 
if W4<261 and W6>260 then frente_oblq_direita_x
goto inicio

frente300:
low portc 0
high portc 5
low portc 6
high portc 7
low 0
high 1
low 2
high 3
low 4' desliga o dribulador
pwmout portc 1, 10,24'motores do lado direito
pwmout portc 2, 10,26''motores do lado esquerdo        
goto linha_xx_frente

'########

parado_linha_virado:
low portc 0
low portc 5
low portc 6
low portc 7
low 0
low 1
low 2
low 3
low 4 'liga o dribulador
goto linha_xx_virado

linha_xx_virado:
i2cslave $E0,i2cfast,i2cbyte	
i2cwrite 0,(81)		
pause 40			
i2cread 2,(b11, b10)	' Read in  high byte and low byte (escreve na W5)
low 7
PULSOUT 7, 1  
PULSIN 4, 1, w1
if W1<260 and W5<61 then parado_linha_virado
if W1>260 and W5>60 then linha_xx_virado_1          
if W1>260 and W5<61 then linha_xx_frente
if W1<261 and W5>60 then linha_xx_virado_1
goto inicio


linha_xx_virado_1:
low 5
PULSOUT 5, 5   'Ultra Sons e escreve na w6-lado direito
PULSIN 0, 1, w6
pause 20
low 6
PULSOUT 6, 5   'Ultra Sons e escreve na w4-lado esquerdo
PULSIN 1, 1, w4                                                 
if W4<260 and W6<260 then recuar300virado
if W4>260 and W6>260 then inicio'          
if W4>260 and W6<261 then recua_oblq_esqerda_virado 
if W4<261 and W6>260 then recua_oblq_direita_virado
goto inicio

recuar300virado:
high portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
high 2
low 3
high 4 'liga o dribulador
pwmout portc 1,10,22
pwmout portc 2,10,26
goto linha_xx_virado_1

'»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»


recua_oblq_direita_x:
low 7
PULSOUT 7, 1   'pino B7 Ultra Sons e escreve na w1
PULSIN 4, 1, w1
if w1<250 then recua_oblq_direita_x1
if w1>249 then lado_direito_xx
goto inicio

recua_oblq_direita_virado:
low 7
PULSOUT 7, 1   'pino B7 Ultra Sons e escreve na w1
PULSIN 4, 1, w1
if w1<250 then recua_oblq_direita_x1_virado
if w1>249 then lado_direito_xx
goto inicio

recua_oblq_direita_x1:
low portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
low 2
low 3
high 4 'liga o dribulador
pwmout portc 1, 10, 32
pwmout portc 2, 10, 30
pause 500
goto inicio

recua_oblq_direita_x1_virado:
low portc 0
low portc 5
high portc 6
low portc 7
high 0
low 1
low 2
low 3
high 4 'liga o dribulador
pwmout portc 1, 10, 32
pwmout portc 2, 10, 30
pause 500
goto parado_linha_kk


recua_oblq_esqerda_x:
low 7
PULSOUT 7, 1   'pino B7 Ultra Sons e escreve na w1
PULSIN 4, 1, w1
if w1<250 then recua_oblq_esquerda_x1
if w1>249 then lado_esquerdo_xx
goto inicio

recua_oblq_esqerda_virado:
low 7
PULSOUT 7, 1   'pino B7 Ultra Sons e escreve na w1
PULSIN 4, 1, w1
if w1<250 then recua_oblq_esquerda_x1_virado
if w1>249 then lado_esquerdo_xx
goto inicio

recua_oblq_esquerda_x1:
high portc 0
low portc 5
low portc 6
low portc 7
low 0
low 1
high 2
low 3
high 4 'liga o dribulador
pwmout portc 1, 10, 32
pwmout portc 2, 10, 30
pause 500
goto inicio

recua_oblq_esquerda_x1_virado:
high portc 0
low portc 5
low portc 6
low portc 7
low 0
low 1
high 2
low 3
high 4 'liga o dribulador
pwmout portc 1, 10, 32
pwmout portc 2, 10, 30
pause 500
goto parado_linha_kk

lado_esquerdo_xx:
high portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
high 2
low 3
pwmout portc 1, 10,26 '??????????????????????????
pwmout portc 2, 10,26
pause 500 
goto parado_linha_kk

lado_direito_xx:
low portc 0
high portc 5
high portc 6
low portc 7
high 0
low 1
low 2
high 3
pwmout portc 1, 10, 26    '??????????????
pwmout portc 2, 10, 26
pause 500 
goto parado_linha_kk


frente_oblq_esqerda_x:
low portc 0
low portc 5
low portc 6
high portc 7
low 0
high 1
low 2
low 3
low 4 ' dribulador
pwmout portc 1, 10, 30    'motores do lado direito            
pwmout portc 2, 10, 30     'motores do lado esquerdo
pause 400 
goto parado_linha_kk

frente_oblq_direita_x:
low portc 0
high portc 5
low portc 6
low portc 7
low 0
low 1
low 2
high 3
low 4 ' dribulador
pwmout portc 1, 10, 30    'motores do lado direito          
pwmout portc 2, 10, 30    'motores do lado esquerdo 
pause 400
goto parado_linha_kk



parado_linha_kk:
low portc 0
low portc 5
low portc 6
low portc 7
low 0
low 1
low 2
low 3
low 4 'liga o dribulador
pause 500
goto inicio


