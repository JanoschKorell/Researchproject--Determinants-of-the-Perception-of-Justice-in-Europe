*Masterforschungsprojekt
*WiSe 2021/22
*MP20211211

*Plots

capture log close
use $data/ESS7, clear
log using $lofi/LogFilePlots, replace
set more off, perm
numlabel _all, add force

graph set window fontface "Times New Roman"

********************************************************************************
*In diesem DoFile wird durchgeführt:
*1. Maps
*2. Koefplots
********************************************************************************


*1 Maps
ssc install geo2xy
*1.1 AVen nach Länder

cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken/Map_Material"


*Durchschnitt
egen DichAVBedarfM = mean(100*DichAVBedarf), by(Land)
egen DichAVLeistungM = mean(100*DichAVLeistung), by(Land)
egen DichAVGleichheitM = mean(100*DichAVGleichheit), by(Land)
egen DichAVAnrechtM = mean(100*DichAVAnrecht), by(Land)

keep  idno DichAVBedarfM DichAVLeistungM DichAVGleichheitM DichAVAnrechtM Wohlfahrtsstaaten cntry Land

sort cntry

egen tag = tag(Land)
drop if tag == 0
drop tag 


foreach v of var * { 
	drop if missing(`v') 
}



replace DichAVBedarfM=round(DichAVBedarfM, 0.1)
replace DichAVLeistungM=round(DichAVLeistungM, 0.1)
replace DichAVGleichheitM=round(DichAVGleichheitM, 0.1)
replace DichAVAnrechtM=round(DichAVAnrechtM, 0.1)

save ESSPrep, replace
clear

*********Map***********
spshape2dta "NUTS_RG_03M_2016_4326_LEVL_0.shp", replace saving(nuts0)
spshape2dta "NUTS_RG_03M_2016_4326_LEVL_1.shp", replace saving(nuts1)
spshape2dta "NUTS_RG_03M_2016_4326_LEVL_2.shp", replace saving(nuts2)
spshape2dta "NUTS_RG_03M_2016_4326_LEVL_3.shp", replace saving(nuts3)

foreach x in nuts0 nuts1 nuts2 nuts3 {
use `x', clear
  replace NUTS_ID = "GB" if  NUTS_ID == "UK"
 save, replace
}

foreach x in nuts0 nuts1 nuts2 nuts3 {
use `x', clear
  replace CNTR_CODE = "GB" if  CNTR_CODE == "UK"
 save, replace
}

foreach x in nuts0 nuts1 nuts2 nuts3 {

use `x', clear
  
  replace LEVL_CODE = 1 if  inlist(CNTR_CODE, "AT", "BE", "BG", "CH", "CY", "CZ")
  replace LEVL_CODE = 1 if  inlist(CNTR_CODE, "HR", "HU", "IE", "IS", "IT", "LT", "LV", "ME")
  replace LEVL_CODE = 1 if  inlist(CNTR_CODE, "NL", "NO", "PL", "PT", "RS", "SE",  "SI", "SK")
  replace LEVL_CODE = 1 if  inlist(CNTR_CODE, "DE", "DK", "EE", "ES", "FI", "FR", "GB")
  keep if LEVL_CODE == 1
  save, replace
}

foreach x in nuts0 nuts1 nuts2 nuts3 {
  use `x'_shp, clear
    keep if _X > -10 & _Y >20  | _ID == 18 geo2xy _Y _X, proj(web_mercator) replace
	save, replace
}
 
foreach x in nuts0 nuts1 nuts2 nuts3 {

use `x', clear
  
  rename CNTR_CODE cntry
  save, replace

}

use nuts0, clear

merge 1:1 cntry using ESSPrep

colorpalette cividis, ipolate(18, power(1.2)) nograph reverse 
local colors `r(p)'

spmap DichAVBedarfM using nuts0_shp, ///
id(_ID) cln(18) fcolor("`colors'") ///
ocolor(gs6 ..) osize(0.03 ..) ///
ndfcolor(gs14) ndocolor(gs6 ..) ndsize(0.03 ..) ndlabel("No data") ///
legend(pos(7) size(1.5))  legstyle(2) ///
title("Bedarfsgerechtigkeit in % pro Land", size(medsmall))
cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken"
graph export "Map Bedarfsgerechtigkeit.jpg", replace as(png) width(16000)
cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken/Map_Material"



colorpalette cividis, ipolate(18, power(1.2)) nograph reverse 
local colors `r(p)'

spmap DichAVLeistungM using nuts0_shp, ///
id(_ID) cln(18) fcolor("`colors'") ///
ocolor(gs6 ..) osize(0.03 ..) ///
ndfcolor(gs14) ndocolor(gs6 ..) ndsize(0.03 ..) ndlabel("No data") ///
legend(pos(7) size(1.5))  legstyle(2) ///
title("Perzeption der Leistungsgerechtigkeit in % pro Land", size(medsmall)) ///
note("Quelle: ESS9", size(tiny))
cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken"
graph export "Leistungsgerechtigkeit.jpg", replace as(png) width(2480)
cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken/Map_Material"



colorpalette cividis, ipolate(18, power(1.2)) nograph reverse 
local colors `r(p)'

spmap DichAVGleichheitM using nuts0_shp, ///
id(_ID) cln(18) fcolor("`colors'") ///
ocolor(gs6 ..) osize(0.03 ..) ///
ndfcolor(gs14) ndocolor(gs6 ..) ndsize(0.03 ..) ndlabel("No data") ///
legend(pos(7) size(1.5))  legstyle(2) ///
title("Gleichheit in % pro Land", size(medsmall))
cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken"
graph export "Gleichheit.jpg", replace as(png) width(16000)
cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken/Map_Material"



colorpalette cividis, ipolate(18, power(1.2)) nograph reverse 
local colors `r(p)'

spmap DichAVAnrechtM using nuts0_shp, ///
id(_ID) cln(18) fcolor("`colors'") ///
ocolor(gs6 ..) osize(0.03 ..) ///
ndfcolor(gs14) ndocolor(gs6 ..) ndsize(0.03 ..) ndlabel("No data") ///
legend(pos(7) size(1.5))  legstyle(2) ///
title("Anrechtsgerechtigkeit in % pro Land", size(medsmall))
cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken"
graph export "Anrechtsgerechtigkeit.jpg", replace as(png) width(16000)
cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken/Map_Material"
 
 
 
*1.2 Wohlfahrtsstaaten 
 
// Wohlfahrtsmap

colorpalette #c7daa9 #f49bb1 #ffffbf #ffc37a #9bb2e5, nograph  
local colors `r(p)'

spmap Wohlfahrtsstaaten using nuts0_shp, ///
id(_ID) cln(20) fcolor("`colors'") ///
ocolor(gs7 ..) osize(0.03 ..) ///
ndfcolor(gs14) ndocolor(gs7 ..) ndsize(0.03 ..) ndlabel("No data") ///
legend(order( 6 "Osten" 5 "Mediterran" 4 "Skandinavisch" 3 "Konservativ/bismarckisch" 2 "Liberal/angelsächsisch") pos(7) size(1.5))  legstyle(1) ///
title("Wohlfahrtsstaatstypen in Europa nach Fearra", size(medsmall))
cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken"
graph export "Wohlfahrtsstaatstypen in Europa nach Fearra.jpg", replace as(png) width(16000)
cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken/Map_Material"
*/

ssc install coefplot


*2 Koefplot
// Structural Respondent Characteristics
coefplot AV1 AV2 AV3 AV4, ///
recast(bar) barw(0.15) vertical ///
ciopts(recast(rcap) color(gs8)) citop ///
drop(_cons Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc  Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2) ///
mlabel("{it:p} = " + string(@pval,"%9.3f")) ///
xlabel(, angle(90)) ///
legend(order(1 "Gleichheit" 3 "Leistung" 5 "Bedarf" 7 "Anrecht")) ///
xlabel(1"Geschlecht" 2"Alter-Jung" 3"Alter-Mittel" 4"Alter-Alt" 5"Arbeitslosigkeit" 6"Sozialleistung" 7"Einkommen" 8"Bildung niedrig" 9"Bildung hoch", angle(0) labsize(vsmall)) ///
legend(pos(6) col(4)) ///
ytitle("AMEs") ///
title("Coefplot: Perzeptionen von Gerechtigkeiten in Europa", size(*0.7)) ///
subtitle("Structural Respondent Characteristics")

cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken/"
graph export "Coefplot Gerechtigkeiten Structural Respondent Characteristics.jpg", replace as(png) width(16000)
*cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Data/ESS_9/"



// Ideational Respondent Characteristics
coefplot AV1 AV2 AV3 AV4, ///
recast(bar) barw(0.15) vertical ///
ciopts(recast(rcap) color(gs8)) citop ///
drop(_cons  Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand ///
BildungNiedrig_cmc BildungHoch_cmc   Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2) ///
mlabel("{it:p} = " + string(@pval,"%9.3f")) ///
xlabel(, angle(90)) ///
legend(order(1 "Gleichheit" 3 "Leistung" 5 "Bedarf" 7 "Anrecht")) ///
xlabel(1"Religion" 2"Politische Einstellung" 3"Vertrauen in Institutionen" 4"Vertrauen in Mitmenschen" 5"Zufriedenheit mit dem Staat", angle(0) labsize(vsmall)) ///
legend(pos(6) col(4)) ///
ytitle("AMEs") ///
title("Coefplot: Perzeptionen von Gerechtigkeiten in Europa", size(*0.7)) ///
subtitle("Ideational Respondent Characteristics")

cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken/"
graph export "Coefplot Gerechtigkeiten Ideational Respondent Characteristics.jpg", replace as(png) width(16000)
*cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Data/ESS_9/"



// Länderindikatoren
coefplot AV1 AV2 AV3 AV4, ///
recast(bar) barw(0.15) vertical ///
ciopts(recast(rcap) color(gs8)) citop ///
drop(_cons   Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand ///
BildungNiedrig_cmc BildungHoch_cmc Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc  ) ///
mlabel("{it:p} = " + string(@pval,"%9.3f")) ///
xlabel(, angle(90)) ///
legend(order(1 "Gleichheit" 3 "Leistung" 5 "Bedarf" 7 "Anrecht")) ///
xlabel(1"Arbeitslosigkeitsquote" 2"Gini-Index" 3"Bip pro Kopf" 4"Sozialleistungsquote", angle(0) labsize(vsmall)) ///
legend(pos(6) col(4)) ///
ytitle("AMEs") ///
title("Coefplot: Perzeptionen von Gerechtigkeiten in Europa", size(*0.7)) ///
subtitle("Länderindikatoren")

cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken/"
graph export "Coefplot Gerechtigkeiten Laenderindikatoren.jpg", replace as(png) width(16000)
*cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Data/ESS_9/"


// Wohlfahrtsstaaten
coefplot AME16s AME26s AME36s AME46s, mlabposition(1) ///
recast(bar) barw(0.15) vertical ///
ciopts(recast(rcap) color(gs8)) citop ///
drop(_cons Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand ///
BildungNiedrig_cmc BildungHoch_cmc Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2) ///
legend(order(1 "Gleichheit" 3 "Leistung" 5 "Bedarf" 7 "Anrecht")) ///
legend(pos(6) col(4)) ///
ytitle("AMEs") ///
xlabel(1"Monarchien" 2"Liberaler WS-Typ" 3"Konservativer WS-Typ" 4"Sozialdemokratischer WS-Typ" 5"Mediterraner WS-Typ", angle(0) labsize(vsmall)) ///
title("Coefplot: Perzeptionen von Gerechtigkeiten in Europa", size(*0.7)) ///
subtitle("Ländertypologien")

cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Grafiken/"
graph export "Coefplot Gerechtigkeiten Ländertypologien.jpg", replace as(png) width(16000)
*cd "C:/Users/admin/Dropbox/Masterforschungsprojekt_Gerechtigkeit/22_Daten/Data/ESS_9/"



save $data/ESS8.dta, replace
