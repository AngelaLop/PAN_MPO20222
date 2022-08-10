



		*----------------------- loading and Harmonization Data -----------------------*
		
		*datalibweb, country(pan) year(2019) type(sedlac-03) mod(all) clear
		
		*cap keep if cohh==1 

/*===============================================================================================
                                  0: Constructing variables
===============================================================================================*/

*Age range

		* Country Names and ISO
		local ind 	 "pan"
		local ind_lb "Panama"
		*local yr "19"
		
*Generating variables
cap drop total informal 
cap gen total = 1
cap gen mujer = (hombre==0)
cap gen e_15_mas = edad>=15

cap g pondera = fac15_e
cap g relacion = p1
cap g jefe = inlist(p1,1)
cap g jefe_h=sexo_jefe
cap replace jefe_h =0 if jefe_h==2

cap g jefa = 1 if jefe_h==0 & jefe==1
cap replace jefa= 0 if jefe_h==1 & jefe==1

* regiones

	encode region_est2, g(region)
	
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
	
* area
g rural = (urbano==0)
*g rural_agro = (_s1001==1) & (rural==1) 	
	
* nivel educativo 
g e_ninguno = inlist(nivel,0,1)
g e_primaria = inlist(nivel,2,3)  
g e_secundaria  = inlist(nivel,4,5) 
g e_terciaria  = inlist(nivel,6)  

g horas_reducidas =.
g salario_reducido =.
g inasistencia_covid =. 
g alimen =.
g pagar  =.
g confli =.
g abando =.
g salud  =.
g citas  =.
g escola =. 
g ansied =.
g ingres =.

g phone =.
 
* Ocupado
/* p08_16_ocu: Condición de actividad    
		 1,2,3,4,5,8 = ocupado
		       6,7,9 = desocupado
     10,11,12,13,14,15,16,17 = inactivo							
    
   P27A_COND: Definición oficial de condición actividad (no coincide 100% con la nuestra)  */
  
cap drop ocupado desocupa pea
destring p10_18, replace 
gen	ocupado = 0	if  p10_18>=1 & p10_18<=17
replace ocupado = 1	if (p10_18>=1 & p10_18<=5) | p10_18==8
replace ocupado = . if edad < 15
notes   ocupado: people aged 10 and older
notes   ocupado: period of reference: last week

* Desocupado
gen	desocupa = 0	if  ocupado==1
replace desocupa = 1	if  p10_18==6 | p10_18==7 | p10_18==9 | p10_18==10
replace desocupa = . if edad < 15
notes   desocupa: people aged 10 and older
notes   desocupa: period of reference: last week

* Población económicamente activa

gen	pea = 0 if edad>=15
replace pea = 1		if  ocupado==1 | desocupa==1
notes   pea: people aged 15 and older
notes   pea: period of reference: last week 
 
  
 
gen ocupado_1 = ocu_des=="Ocupados" if edad>=15
gen desocupado_1 =  ocu_des=="Desocupados" if edad>=15
gen pea_1 = (desocupado_1==1)| (ocupado_1==1)
replace pea_1=. if edad<15


replace desocupado_1=. if pea_1==0
*rama agregada
	cap g rama= p30reco
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
	g informal3 =0 if ocupado ==1
	replace informal =1 if p4!=1 & ocupado ==1	
	replace informal =1 if p34==5
	replace informal =0 if p4==1 | p4 == 4 & ocupado ==1	
	replace informal =. if rama==1 //  ocupados exuyendo ocupaciones agricultura
	replace informal =. if ocupados_no_prof==0 //* ocupados exuyendo  profecionales y tecnicos cuenta propia o patronos
* condicion de la ocupacion 

g ocupacion = p28reco

g horas_1 = p40	
	
*-- educacion 
g asistencia_k12 = 0 if edad>=6 & edad<=17
replace asistencia_k12=1 if p7==1 & edad>=6 & edad<=17
g inasistencia_k12 = 0 if edad>=6 & edad<=17
replace inasistencia_k12 = 1 if p7==2 & edad>=6 & edad<=17
	
g ninis =0 if edad>=15 & edad<=24
replace ninis =1 if p7==2 & ocupado_1==0 & (edad>=15 & edad<=24)

*= subsidios 

// Indigenous
	tab p4d_indige [w=pondera]
	tab indi_rec [w=pondera]

	tab p4d_indige indi_rec [w=pondera]
	destring p4d_indige, replace

	gen indig = (p4d_indige!=11)
	replace indig = . if p4d_indige==.
	

// Afro-decendants
	tab p4f_afrod [w=pondera]

	destring p4f_afrod, replace

	gen afrod = (p4f_afrod!=8)
	replace afrod = . if p4f_afrod==.

*Red Oportunidades / 120 a los 65 
	gen red_12065=0
	replace red_12065 = 1 if p56_g1>0 & p56_g1!=.  // Red Oportunidades
	replace red_12065 = 1 if p56_g5>0 & p56_g5!=.  // 120 a 65

	
	gen red = 0
	replace red = 1 if p56_g1 > 0 & !missing(p56_g1)
	gen pen12065 = 0
	replace pen12065 = 1 if p56_g5 > 0 & !missing(p56_g5)
	gen angel = 0
	replace angel = 1 if p56_g6 > 0 & !missing(p56_g6)
	
	gen ben_main_cct = 0
	replace ben_main_cct = 1 if red == 1 | pen12065 == 1 | angel == 1
	tab ben_main_cct [w=pondera]
	
	egen hh_main_cct = max(ben_main_cct), by(id) /*household benefits from main cash transfers*/
	egen main_cct_income = rsum(p56_g6 p56_g5 p56_g1 )
	g inla_2 = inla-main_cct_income



* Panama Solidario

cap destring p56_b11 p56_b12 p56_b13, replace 

g beneficiario = . 
g ps_bolsa = .
g ps_bono = .
g ps_vale = .
g hh_beneficiario = .


