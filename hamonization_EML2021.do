/*==================================================
project:       
Author:        Angela Lopez 
----------------------------------------------------
Creation Date:    11 May 2021 - 10:24:17
==================================================*/

/*==================================================
              0: Program set up
==================================================*/



g total =1
cap drop ano 
g ano = 2021
cap g id = llave_sec
cap g pondera = fac15_e
cap g relacion = p1
cap g jefe = inlist(p1,1)
destring p2, replace 
cap g hombre = p2==1
g mujer = p2==2

g jefe_m = 1 if jefe==1 & mujer==1
g jefe_h = 1 if jefe==1 & hombre==1
cap g edad = p3
destring edad, replace 

*grupos de edad

cap g gedad1 = 1 if inrange(edad,0,9) // 0-9
replace gedad1 = 2 if inrange(edad,10,14) //10-14
replace gedad1 = 3 if inrange(edad,15,24) //15-24
replace gedad1 = 4 if inrange(edad,25,39) //25-39
replace gedad1 = 5 if inrange(edad,40,59) //40-59
replace gedad1 = 6 if edad >=60 // 60

label var gedad1 "Grupos de edad"
label define grupos_e 1 "0-09" 2 "10-14" 3 "15-24" 4 "25-39" 5 "40-59" 6 "60+", replace
label values gedad1 grupos_e

* etnias
g indig = 1
destring p4d_indige p4f_afrod, replace 
replace indig = 0 if p4d_indige == 11

destring p4f_afrod, replace 
g afrod = 1
replace afrod = 0 if p4f_afrod == 8


destring p10_18, replace 
gen	ocupado = 0	if  p10_18>=1 & p10_18<=17
replace ocupado = 1	if (p10_18>=1 & p10_18<=5) | p10_18==8
notes   ocupado: people aged 10 and older
notes   ocupado: period of reference: last week

* Desocupado
gen	desocupa = 0	if  ocupado==1
replace desocupa = 1	if  p10_18==6 | p10_18==7 | p10_18==9 | p10_18==10
notes   desocupa: people aged 10 and older
notes   desocupa: period of reference: last week

* Población económicamente activa

gen	pea = 0 if edad>=15
replace pea = 1		if  ocupado==1 | desocupa==1
notes   pea: people aged 15 and older
notes   pea: period of reference: last week 

*---------------------------------------------------

* ocupado
g ocupado_1 = 0
replace ocupado_1 = 1 if ocu_des=="Ocupados"
replace ocupado_1 = . if edad<15

* desocupado
g desocupado_1 = 0
replace desocupado_1 = 1 if ocu_des=="Desocupados"
replace desocupado_1 = . if edad<15

*pea 
gen pea_1 = .
replace pea_1=1 if ocupado_1 ==1 | desocupado_1==1
replace pea_1=0 if pea_1 == . & edad>=15

g phone =1 if h2b_celula=="1" | h2c_resi=="1"

replace desocupado_1 = . if pea_1==0
*sector economico


* area
cap g urbano = (area=="Urbana")
	g rural = (area=="Rural")
	
	destring provincia, replace 
	g region = provincia 
	
	g Bocas_del_Toro 	= (region==1)
	g Cocle 			= (region==2)
	g Colon 			= (region==3)
	g Chiriqui 			= (region==4)
	g Darien 			= (region==5)
	g Herrera 			= (region==6)
	g Los_Santos		= (region==7)
	g Panama 			= (region==8)
	g Veraguas 			= (region==9)
	g Comarca_Kuna_Yala = (region==10)
	g Comarca_Embera 	= (region==11)
	g Comarca_Ngobe_Bugle = (region==12)
	g Panama_Oeste 		= (region==13)
	
	g comarcas   = inlist(region,10,11,12)
	g provincias = (comarcas==0)
	
*rama agregada
	destring p30reco, replace 
	g rama= p30reco
	replace rama =.   if ocupado!=1
	cap gen rama_a =1 if inlist(rama,1)  // Agricultura
	replace rama_a =2 if inlist(rama,3) // industria  	
	replace rama_a =3 if inlist(rama,2,4,5) // otras 	
	replace rama_a =4 if inlist(rama,6) // Construcción
	replace rama_a =5 if inlist(rama,7) // Comercio
	replace rama_a =6 if inlist(rama,8) // Transporte
	replace rama_a =7 if inlist(rama,9) // hotles restaur
	replace rama_a =8 if inlist(rama,13,14,16,17,19,18,21,20) // Servicios comunales, sociales y personales
	replace rama_a =9 if inlist(rama,15) //Adm. Pública y Defensa
	replace rama_a =10 if inlist(rama,10,11,12) //financieras, inmobiliarias y de comunicacion
	
	*rama agregada sectores
	cap gen rama_sec =1 if inlist(rama,1)  // Agricultura
	replace rama_sec =2 if inlist(rama,2,3,4,5,6) // industria  	
	replace rama_sec =3 if rama > 6 // servicios  	
	
	cap gen rama_s =1 if inlist(rama,1)  // Agricultura
	replace rama_s =2 if inlist(rama,2,3,4,5,6) // industria  		
	replace rama_s =3 if inlist(rama,7) // comercio
	replace rama_s =4 if rama>7 // servicios
	
	gen agricultura = (rama_s==1) & ocupado==1
	gen industria = (rama_s==2) & ocupado==1
	gen comercio  = (rama_s==3) & ocupado==1
	gen servicios = (rama_s==4) & ocupado==1

	destring  p28reco, g(ocupacion_1)	
* posicion 	
	gen posicion = p33
	replace posicion =.  if ocupado!=1
	replace posicion = 2 if inlist(posicion,2,3,4,9)
	g ocupados_no_prof = ocupado ==1
	replace ocupados_no_prof = 0 if inlist(posicion,7,8) & (inlist(ocupacion_1,1,2)) & ocupado==1
	
	
	g pos_em_gobierno = (posicion==1)
	g pos_em_privado  = (posicion==2)
	g pos_em_domestico = (posicion==5)
	g pos_ind_cuentap = (posicion==7)
	g pos_ind_patron  = (posicion==8)
	g pos_cooperativa = (posicion==9)
	g pos_trab_familiar = (posicion==10)
	

* informalidad	
	g informal =0 if ocupado ==1
	replace informal =1 if p4!=1 & ocupado ==1	
	replace informal =1 if p34==5
	replace informal =0 if p4==1 | p4 == 4 & ocupado ==1	
	replace informal =. if rama==1 //  ocupados exuyendo ocupaciones agricultura
	replace informal =. if ocupados_no_prof==0 //* ocupados exuyendo  profecionales y tecnicos cuenta propia o patronos
* condicion de la ocupacion 



g horas_1 = p40	


* jubilacion 
destring p56_a p56_b, replace

g pension = 0 
replace pension = 1 if p56_a !=.

g pen_accidente = 0 
replace pen_accidente = 1 if p56_b !=.



* nivel educativo 
	g e_ninguno = inlist(p8,1,2,3,4,11,12,13,14,15)  
	g e_primaria = inlist(p8,16,21,22,31,32,33,34,35)  
	g e_secundaria  = inlist(p8,23,36,41,42,51,52,53,54) 
	g e_terciaria  = inlist(p8,55,56,61,71,72,82,83,84)   
	
* nivel

 g nivel_e = 0 if  e_ninguno==1 & jefe==1
 replace nivel_e = 1 if e_primaria ==1 & jefe==1
 replace nivel_e = 2 if e_secundaria ==1 & jefe==1
 replace nivel_e = 3 if e_terciaria ==1 & jefe==1
 
 * nivel educativo jefe_h

 egen jh_nivel_e = max(nivel_e) , by(id) 
  
*--------------------------------------Variables Hogar Covid 

destring h1c_pagar h1d_confli h1e_abando h1f_salud h1f1_citas h1g_escola h1h_ansied h1i_ingres h1a_alimen, replace 
*
g pagar  = (h1c_pagar==1)
g confli = (h1d_confli==1)  
g abando = (h1e_abando==1) 
g salud  = (h1f_salud==1)
g citas  = (h1f1_citas==1) 
g escola = (h1g_escola==1) 
g ansied = (h1h_ansied==1)
g ingres = (h1i_ingres==1)
g alimen = (h1a_alimen==1)


*---------- personas 
*-- trabajo 
*tab p43a, g(horas_)
g horas_reducidas = .
*-- ingreso 
destring p42c, replace 
g salario_reducido = (p42c==1) if ocupado==1
*-- educacion 
g asistencia_k12 = 0 if edad>=6 & edad<=17
replace asistencia_k12=1 if p7==1 & edad>=6 & edad<=17
g inasistencia_k12 = 0 if edad>=6 & edad<=17
replace inasistencia_k12 = 1 if p7==2 & edad>=6 & edad<=17

destring p7a_motivo, replace 
g inasistencia_covid = 0 if inasistencia_k12==1
replace inasistencia_covid = 1 if inasistencia_k12==1 & p7a_motivo==13


g ninis =0 if edad>=15 & edad<=24
replace ninis =1 if p7==2 & ocupado==0 & (edad>=15 & edad<=24)
/* End of do-file */

** panama solidario
destring p56_b11 p56_b12 p56_b13, replace 

g beneficiario = 0 if inlist(gedad1,3,4,5,6)
replace beneficiario = 1 if p56_b11 !=. | p56_b12 !=. | p56_b13 !=. 

g ps_bolsa = 0 if beneficiario ==1
replace ps_bolsa = 1 if p56_b11 !=.

g ps_bono = 0 if beneficiario ==1
replace ps_bono = 1 if  p56_b12 !=.

g ps_vale = 0 if beneficiario ==1
replace ps_vale = 1 if  p56_b13 !=.


egen  hh_beneficiario = max(beneficiario), by (id)	