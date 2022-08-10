
if "`variable'" =="" local name ""

if "`variable'" =="alimen" 		 	local name "Problemas para conseguir alimentos"
if "`variable'" =="limpie" 		 	local name "Problemas para adquirir insumos de limpieza"
if "`variable'" =="pagar"  		 	local name "Problemas para pagar sus créditos o alquileres"
if "`variable'" =="confli" 		 	local name "Conflictos familiares o de pareja"
if "`variable'" =="abando" 		 	local name "Situación de abandono o soledad"
if "`variable'" =="salud"  		 	local name "Falta de seguimiento de su salud o de los suyos por las autoridades sanitarias"
if "`variable'" =="citas" 		 	local name "Pérdida de citas o controles médicos por otro tipo de enfermedad"
if "`variable'" =="escola" 		 	local name "Afectaciones en la continuidad escolar o académica de sus hijos"
if "`variable'" =="ansied" 		 	local name "Estados de ansiedad, nerviosismo o depresión" 
if "`variable'" =="ingres" 		 	local name "Reducción de los ingresos del hogar" 
if "`variable'" =="horas_reducidas"  local name "Reducción de horas laborales"
if "`variable'" =="salario_reducido" local name "Reducción del ingreso percivido"
if "`variable'" =="ocupado_1" 	 	local name "Ocupados"
if "`variable'" =="desocupado_1" 	local name "Desocupados"
if "`variable'" =="ninis" 		 	local name "Jovenes que no estudian ni trabajan"
if "`variable'" =="asistencia_k12" 	local name "Asiste a la escuela"
if "`variable'" =="inasistencia_k12" local name "No asiste a la escuela"
if "`variable'" == "inasistencia_covid" local name "Inasistencia escolar debida al COVID-19"
if "`variable'" =="pea_1" 			local name "PEA"
if "`variable'" =="informal" 		local name "Informal" 
if "`variable'" =="pos_em_gobierno" local name "Empleado(a) del Gobierno" 
if "`variable'" =="pos_em_privado" 	local name "Empleado(a) empersa priv" 
if "`variable'" =="pos_em_domestico" local name "Empleado(a) servicio domestico"  
if "`variable'" =="pos_ind_cuentap" local name "Indep. Por cuenta propia" 
if "`variable'" =="pos_ind_patron" 	local name "Indep. Patrono(a) dueño(a)" 
if "`variable'" =="pos_cooperativa" local name "Miembro de una cooperativa de producción"  
if "`variable'" =="pos_trab_familiar" local name "Trabajador(a) familiar"  
      
 
if "`variable'" =="alimen" local indicador "Hogares que debido al COVID-19 en los ultimos seis meses han presentado:"
if "`variable'" =="limpie" local indicador "Hogares que debido al COVID-19 en los ultimos seis meses han presentado:"
if "`variable'" =="pagar"  local indicador "Hogares que debido al COVID-19 en los ultimos seis meses han presentado:"
if "`variable'" =="confli" local indicador "Hogares que debido al COVID-19 en los ultimos seis meses han presentado:"
if "`variable'" =="abando" local indicador "Hogares que debido al COVID-19 en los ultimos seis meses han presentado:"
if "`variable'" =="salud"  local indicador "Hogares que debido al COVID-19 en los ultimos seis meses han presentado:"
if "`variable'" =="citas" local indicador "Hogares que debido al COVID-19 en los ultimos seis meses han presentado:"
if "`variable'" =="escola" local indicador "Hogares que debido al COVID-19 en los ultimos seis meses han presentado:"
if "`variable'" =="ansied" local indicador "Hogares que debido al COVID-19 en los ultimos seis meses han presentado:" 
if "`variable'" =="ingres" local indicador "Hogares que debido al COVID-19 en los ultimos seis meses han presentado:" 
if "`variable'" =="horas_reducidas"  local indicador "Ocupados cuyas horas de trabajo semanales se han reducido a causa de la pandemia"
if "`variable'" =="salario_reducido" local indicador "Ocupados cuyo salario o ingreso actual se ha reducido a causa de la pandemia" 
if "`variable'" =="ocupado_1" 	 local indicador "Tasa de Ocupacion"
if "`variable'" =="desocupado_1" local indicador "Tasa de Desempleo"
if "`variable'" =="pea_1" local indicador "Tasa de Actividad"
if "`variable'" =="informal" local indicador "Tasa de Informalidad"
if "`variable'" =="ninis" 		 local indicador "Porcentaje de jovenes de 15 a 24 que no estudian ni trabajan"
if "`variable'" =="asistencia_k12" local indicador "Asistencia escolar neta de poblacion de 6 a 18"
if "`variable'" =="inasistencia_k12" local indicador "Inasistencia escolar neta de poblacion de 6 a 18" 
if "`variable'" == "inasistencia_covid" local indicador "Inasistencia escolar debida al COVID-19"  
if "`variable'" == "agricultura"  local indicador "Rama"  
if "`variable'" == "industria" 	local indicador "Rama"  
if "`variable'" == "comercio" local indicador "Rama"  
if "`variable'" == "servicios" local indicador "Rama"  
if "`variable'" =="pos_em_gobierno" local indicador "Posicion" 
if "`variable'" =="pos_em_privado" 	local indicador "Posicion" 
if "`variable'" =="pos_em_domestico" local indicador "Posicion"  
if "`variable'" =="pos_ind_cuentap" local indicador "Posicion" 
if "`variable'" =="pos_ind_patron" 	local indicador "Posicion"  
if "`variable'" =="pos_cooperativa" local indicador "Posicion"   
if "`variable'" =="pos_trab_familiar" local indicador "Posicion"  
 
if "`variable'" =="alimen" local modulo "Seguridad alimentaria"
if "`variable'" =="limpie" local modulo "Cuidado"
if "`variable'" =="pagar"  local modulo "Ingresos"
if "`variable'" =="confli" local modulo "Salud"
if "`variable'" =="abando" local modulo "Salud Mental"
if "`variable'" =="salud"  local modulo "Salud"
if "`variable'" =="citas" local modulo "Salud"
if "`variable'" =="escola" local modulo "Educacion"
if "`variable'" =="ansied" local modulo "Salud Mental" 
if "`variable'" =="ingres" local modulo "Ingresos" 
if "`variable'" =="horas_reducidas"  local modulo "Trabajo"
if "`variable'" =="salario_reducido" local modulo "Ingresos"  
if "`variable'" =="ocupado_1" 	 local modulo "Trabajo"
if "`variable'" =="desocupado_1" local modulo "Trabajo"
if "`variable'" =="ninis" 		 local modulo "Educacion"
if "`variable'" =="asistencia_k12" local modulo "Educacion"
if "`variable'" =="inasistencia_k12" local modulo "Educacion" 
if "`variable'" == "inasistencia_covid" local modulo "Educacion" 
if "`variable'" == "informal" local modulo "Trabajo" 
if "`variable'" == "pea" local modulo "Trabajo" 
 
if "`cut'" =="total" 		local cut_label "Total"  
if "`cut'" =="hombre" 		local cut_label "Sexo" 
if "`cut'" =="mujer" 		local cut_label "Sexo" 
if "`cut'" =="e_ninguno" 	local cut_label "Nivel educativo" 
if "`cut'" =="e_primaria" 	local cut_label "Nivel educativo" 
if "`cut'" =="e_secundaria" local cut_label "Nivel educativo" 
if "`cut'" =="e_terciaria"	local cut_label "Nivel educativo" 
if "`cut'" =="rural" 		local cut_label "Area" 
if "`cut'" =="urbano" 		local cut_label "Area" 
if "`cut'" =="comarcas" 	local cut_label "Region" 
if "`cut'" =="provincias" 	local cut_label "Region" 
         















 
