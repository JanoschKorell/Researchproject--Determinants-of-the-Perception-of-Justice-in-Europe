*Masterforschungsprojekt
*WiSe 2021/22
*Missings/Sample

capture log close
use $data/ESS2, clear
log using $lofi/LogFileMissingsSample, replace
set more off, perm
numlabel _all, add force

********************************************************************************
*In diesem DoFile wird durchgeführt:
*1. Betrachtung der Missings (Misstables)	
*	1. Basisvariaben mit wenigen Missings
*	2. Plus Links/Rechts; Religion
*	3. Plus Indizes
*	4. Basis plus problematische Variablen Sozialleistung und Einkommen
*	5. Alle MikroUVs
*2. FlowChart Missings								
*3. Sample 1: Full-Case-Analysis								!!!
*4. Untersuchung MCAR									
*5. Untersuchung metrische Variablen + Transformationen	
*6. Imputation der Mittelwerte								
*7. Sample 2: Robustheitstest  									!!!
********************************************************************************


*1. Betrachtung der Missings

*1.1 Basisvariaben mit wenigen Missings
misstable patterns DichAVGleichheit DichAVLeistung DichAVBedarf DichAVAnrecht Geschlecht Alter Arbeitslosigkeit BildungsstufeDreiteilung 
//93% ohne Einkommen und Sozialleistung

*1.2 Plus Links/Rechts; Religion
misstable patterns DichAVGleichheit DichAVLeistung DichAVBedarf DichAVAnrecht Geschlecht Alter Arbeitslosigkeit BildungsstufeDreiteilung Religion LinksRechts	//81% + LinksRechts

*1.3 Plus Indizes
misstable patterns DichAVGleichheit DichAVLeistung DichAVBedarf DichAVAnrecht Geschlecht Alter Arbeitslosigkeit BildungsstufeDreiteilung Religion LinksRechts trustInst trustinHumans satiswithstate					
//77% mit Indizes
														  
*1.4 Basis Plus problematische Variablen Sozialleistung und Einkommen
misstable patterns DichAVGleichheit DichAVLeistung DichAVBedarf DichAVAnrecht Geschlecht Alter Arbeitslosigkeit BildungsstufeDreiteilung Religion LinksRechts Sozialleistung EinkommenPercentileLand
//43%				* Sozialleistung fällt heraus
					* Einkommen fällt heraus
					*Analyse missings:
					tab Land if Einkommen == .								
					*Keine Besonderheit in den Missings im Einkommen nach Land

*1.6 Alle MikroUVs und AVs
misstable patterns DichAVGleichheit DichAVLeistung DichAVBedarf DichAVAnrecht Geschlecht Alter Arbeitslosigkeit BildungsstufeDreiteilung Religion LinksRechts Sozialleistung EinkommenPercentileLand trustInst trustinHumans satiswithstate
//41%


													  
********************************************************************************
*2. FlowChart Missings:
*Ausgabe der Informationen für das in der Arbeit integrierte Flowchart zu Missings

	*Gesamt:
	sum idno		//49.519

	*Alle AVs gültig
	sum idno if DichAVAnrecht != . & ///
			DichAVLeistung != . & ///
			DichAVBedarf != . & ///
			DichAVGleichheit != . 
				//46.827
		
	*Alle AVs und alle UVs gültig, exkl Einkommen/Sozialleistung
	*entspricht SampleImputiert, somit 38.236
				
	*Alle AVs und alle UVs gültig
	*entspricht SampleFCA, somit 20.340				


********************************************************************************
*3. Sample 1: Full-Case-Analysis  
egen Missings = rowmiss(DichAVGleichheit DichAVLeistung DichAVBedarf DichAVAnrecht Geschlecht Alter Arbeitslosigkeit BildungsstufeDreiteilung Religion LinksRechts Sozialleistung EinkommenPercentileLand trustInst trustinHumans satiswithstate)
gen SampleFCA = 1 if Missings == 0
tab SampleFCA			//Stimmt mit Misstable überein; 20,340 Fälle

														  
********************************************************************************
*4. Untersuchung MCAR

*Tests of violation of MCAR assumption
/*
*Problematische Variablen:
*Sozialleistung
	gen Sozialleistungmiss=1
	replace Sozialleistungmiss=0 if Sozialleistung!=.
	tab Sozialleistungmiss, m
	logit Sozialleistungmiss DichAVGleichheit, or //1%%
	logit Sozialleistungmiss DichAVLeistung, or //1%
	logit Sozialleistungmiss DichAVBedarf, or //n.s.
	logit Sozialleistungmiss DichAVAnrecht, or //5%

*Einkommen
	gen Einkommenmiss=1
	replace Einkommenmiss=0 if EinkommenPercentileLand!=.
	tab Einkommenmiss, m
	logit Einkommenmiss DichAVGleichheit, or //1%%
	logit Einkommenmiss DichAVLeistung, or //1%%
	logit Einkommenmiss DichAVBedarf, or //1%%
	logit Einkommenmiss DichAVAnrecht, or //1%%

*Andere zum Test:
*Arbeitslosigkeit
	gen Arbeitslosigkeitmiss=1
	replace Arbeitslosigkeitmiss=0 if Arbeitslosigkeit!=.
	tab Arbeitslosigkeitmiss, m
	logit Arbeitslosigkeitmiss DichAVGleichheit, or //5%
	logit Arbeitslosigkeitmiss DichAVLeistung, or //n.s.
	logit Arbeitslosigkeitmiss DichAVBedarf, or //n.s.
	logit Arbeitslosigkeitmiss DichAVAnrecht, or //5%

*Religion
	gen Religionmiss=1
	replace Religionmiss=0 if Religion!=.
	tab Religionmiss, m
	logit Religionmiss DichAVGleichheit, or //not sig
	logit Religionmiss DichAVLeistung, or //1%%
	logit Religionmiss DichAVBedarf, or //1%%
	logit Religionmiss DichAVAnrecht, or //not sig
*/	

********************************************************************************
*5. Untersuchung metrische Variablen + Transformationen

hist EinkommenPercentileLand, norm
ladder EinkommenPercentileLand
//Perzentile, also verwendbar

hist LinksRechts, norm
ladder LinksRechts		
//Identity, da Mitte sehr ausgeprägt, aber Variable sieht annehmbar aus

hist trustInst, norm
ladder trustInst
//Keine Verbesserung möglich
						
hist trustinHumans, norm
ladder trustinHumans
//Identity, da Mitte sehr ausgeprägt, aber Variable sieht annehmbar aus

hist satiswithstate, norm
ladder satiswithstate
//Keine Verbesserung möglich


********************************************************************************
*6. Imputation der Mittelwerte für problematische Variablen

*5.1 Einkommen
gen EinkommenImputiert = EinkommenPercentileLand
replace EinkommenImputiert = 5 if EinkommenPercentileLand == .
tab EinkommenImputiert, m

*5.2 Sozialleistung
gen SozialleistungImputiert = Sozialleistung
replace SozialleistungImputiert = 0 if Sozialleistung == .a
replace SozialleistungImputiert = 0 if Sozialleistung == .b
replace SozialleistungImputiert = 0 if Sozialleistung == .c
replace SozialleistungImputiert = 0 if Sozialleistung == .d
tab SozialleistungImputiert, m


********************************************************************************
*7. Sample 2: Robustheitstest  

egen MissingsImputiert = rowmiss(DichAVGleichheit DichAVLeistung DichAVBedarf DichAVAnrecht Geschlecht Alter Arbeitslosigkeit BildungsstufeDreiteilung Religion LinksRechts SozialleistungImputiert EinkommenImputiert trustInst trustinHumans satiswithstate)
gen SampleImputiert = 0
replace SampleImputiert = 1 if MissingsImputiert == 0
tab SampleImputiert			//38,236 Fälle



	
save $data/ESS3.dta, replace

