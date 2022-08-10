/*==================================================
project:       
Author:        Angela Lopez 
E-email:       alopezsanchez@worldbank.org
url:           
Dependencies:  
----------------------------------------------------
Creation Date:     11 May 2022 - 16:03:54
Modification Date:   
Do-file version:    01
References:          
Output:             
==================================================*/

/*==================================================
              0: Program set up
==================================================*/
version 17
drop _all

global path "C:\Users\WB585318\WBG\Javier Romero - Panama"
global dos  "${path}\MPO\202208\do files\PAN_MPO20222"
global data1 	"${path}\data"
global data3 	"${path}\data\EPM 2022"
global data 	"${path}\data\harmonized"
global results  "${path}\MPO\202208"


/*==================================================
              0: Program set up
==================================================*/

local anos 2019 2021 
foreach ano of local anos {
use "$data1\EML `ano'\EML`ano'_completa", replace 
include "$dos\hamonization_EML`ano'.do"
save "$data\EH`ano'_h.dta", replace 
}

local ano 2022
use "$data3\EPM2022_completa", replace 
include "$dos\hamonization_EPM2022.do"
save "$data\EH`ano'_h.dta", replace


/*==================================================
              1: Labor market 
==================================================*/

preserve				
	tempfile tablas
	tempname ptablas
	postfile `ptablas' str100(Variable_label Anio Module Variable Indicator Cut Cut_label) Value Numerador using `tablas', replace

	
local anos 2019 2021 2022

foreach ano of local anos {
	
	use "$data\EH`ano'_h.dta", clear 
	
	
*--------------------------------indicators-------------------------------------


*Percentage personas

 local cuts total hombre mujer e_ninguno e_primaria e_secundaria e_terciaria rural urbano comarcas provincias indig afrod
 
 
			
	foreach cut of local cuts {
			
			local variables ocupado desocupa pea ninis asistencia_k12 inasistencia_k12 
			foreach variable of local variables {
			
		    include "$dos\Formatos_EML.do"
			sum `variable' [iw=pondera] if `cut'==1
			local value = r(mean)*100
			local numerador = r(sum_w)
			post `ptablas' ("`name'") ("`ano'") ("`modulo'") ("`variable'") ("`indicador'") ("`cut'") ("`cut_label'") (`value') (`numerador') 
		
	
		}
		
		
* ocupados 

 local variables informal agricultura industria comercio servicios pos_em_gobierno pos_em_privado pos_em_domestico pos_ind_cuentap pos_ind_patron pos_cooperativa pos_trab_familiar
 
			foreach variable of local variables {
		    include "$dos\Formatos_EML.do"
			sum `variable' [iw=pondera] if `cut'==1
			local value = r(mean)*100
			sum `variable' [iw=pondera] if `cut'==1 & `variable'==1
			local numerador = r(sum_w)
			post `ptablas' ("`name'") ("`ano'") ("`modulo'") ("`variable'") ("`indicador'") ("`cut'") ("`cut_label'") (`value') (`numerador') 
		}

* Panama Solidario 		
		
	local variables beneficiario ps_bolsa ps_bono ps_vale ps_vale hh_beneficiario	
			
			foreach variable of local variables {
		    include "$dos\Formatos_EML.do"
			sum `variable' [iw=pondera] if `cut'==1
			local value = r(mean)*100
			local numerador = r(sum_w)
			post `ptablas' ("`name'") ("`ano'") ("`modulo'") ("`variable'") ("`indicador'") ("`cut'") ("`cut_label'") (`value') (`numerador') 
		}
	} /*cierro cut*/
			
} /* cierro anos*/	
	
	
postclose `ptablas'
use `tablas', clear
save `tablas', replace 

export excel using "${results}/00.MPO202208.xlsx", sh("results", replace)  firstrow(var)

restore
