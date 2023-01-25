*Masterforschungsprojekt
*WiSe 2021/22
*Regressionen


capture log close
use $data/ESS4, clear
log using $lofi/LogFileRegressionen, replace
set more off, perm
numlabel _all, add force

********************************************************************************
*In diesem DoFile wird durchgeführt:
*1. Regressionen
*2. Robustheitstests
*3. Modell 4 mit verschiedenen Referenzgruppen
********************************************************************************

********************************************************************************
*1. Regressionen
*Estout install
ssc install estout, replace

*1. Gleichheit
*1. Schritt: Nullmodell (keine prädikatoren)
xtmelogit DichAVGleichheit || Land: if SampleFCA == 1
estat icc			//ICC: 0,148 --> 14,7%
estat ic			//AIC: 25.711
					//BIC: 25.727

					
*2. Schritt: Random-Intercept, Fixed Slope (Prädikatoren auf Ebene 1&2) + Tests Random-Intercept-Random-Slope					
*M1:	CMC	R-I-F-S	
xtmelogit DichAVGleichheit Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc || Land: if SampleFCA == 1, or var		
estat ic											
margins , dydx (_all) noatlegend
eststo AME11s

*M2:	CMC	R-I-F-S	
xtmelogit DichAVGleichheit Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand BildungNiedrig_cmc BildungHoch_cmc || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AME12s

*M3:	CMC	R-I-F-S	
xtmelogit DichAVGleichheit Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
eststo AME13s

*M4:	CMC	R-I-F-S						
xtmelogit DichAVGleichheit Monarchien WSLiberal WSKonserv WSSozialdemo WSMediterran || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AME14s

*M5:	CMC	R-I-F-S	
xtmelogit DichAVGleichheit Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand ///
BildungNiedrig_cmc BildungHoch_cmc Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc  Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
eststo AME15s
eststo AV1

predict PDev1, deviance 
predict PPear1, pearson 
predict mu1
predict fixed1, xb


				
*M6: 	CMC	R-I-F-S						
xtmelogit DichAVGleichheit Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand ///
 BildungNiedrig_cmc BildungHoch_cmc Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc Monarchien WSLiberal WSKonserv WSSozialdemo WSMediterran || Land: if SampleFCA == 1, or var		
estat ic									
margins , dydx (_all) noatlegend
eststo AME16s
esttab AME11s AME12s AME13s AME14s AME15s AME16s using Gleichheit.rtf, replace mtitles se(%9.3f) b(%9.3f) 

					
********************************************************************************
*2. Leistung
*1. Schritt: Nullmodell (keine prädikatoren)
xtmelogit DichAVLeistung || Land: if SampleFCA == 1
estat icc			//ICC: 0,039 --> 3,9%
estat ic			//AIC: 18.719
					//BIC: 18.735
					
*2. Schritt: Random-Intercept, Fixed Slope (Prädikatoren auf Ebene 1&2)					
*M1:
xtmelogit DichAVLeistung Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc || Land: if SampleFCA == 1, or var		
estat ic										
margins , dydx (_all) noatlegend
eststo AME21s

*M2:	CMC	R-I-F-S	
xtmelogit DichAVLeistung Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand BildungNiedrig_cmc BildungHoch_cmc || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AME22s

*M3:	CMC	R-I-F-S	
xtmelogit DichAVLeistung Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
eststo AME23s

*M4:	CMC	R-I-F-S						
xtmelogit DichAVLeistung Monarchien WSLiberal WSKonserv WSSozialdemo WSMediterran || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
eststo AME24s

*M5:	CMC	R-I-F-S	
xtmelogit DichAVLeistung Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand ///
BildungNiedrig_cmc BildungHoch_cmc Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc  Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
eststo AME25s
eststo AV2

predict PDev2, deviance 
predict PPear2, pearson 
predict mu2
predict fixed2, xb

				
*M6: 	CMC	R-I-F-S						
xtmelogit DichAVLeistung Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand ///
 BildungNiedrig_cmc BildungHoch_cmc Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc Monarchien WSLiberal WSKonserv WSSozialdemo WSMediterran || Land: if SampleFCA == 1, or var		
estat ic								
margins , dydx (_all) noatlegend
eststo AME26s
esttab AME21s AME22s AME23s AME24s AME25s AME26s using Leistung.rtf, replace mtitles se(%9.3f) b(%9.3f) 
					
					
********************************************************************************
*3. Bedarf
*1. Schritt: Nullmodell (keine prädikatoren)
xtmelogit DichAVBedarf || Land: if SampleFCA == 1
estat icc			//ICC: 0,102 --> 10,2%
estat ic			//AIC: 20.764
					//BIC: 20.780

*2. Schritt: Random-Intercept, Fixed Slope (Prädikatoren auf Ebene 1&2)					
*M1:
xtmelogit DichAVBedarf Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc || Land: if SampleFCA == 1, or var		
estat ic										
margins , dydx (_all) noatlegend
eststo AME31s

*M2:	CMC	R-I-F-S	
xtmelogit DichAVBedarf Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand BildungNiedrig_cmc BildungHoch_cmc || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AME32s

*M3:	CMC	R-I-F-S	
xtmelogit DichAVBedarf Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
eststo AME33s

*M4:	CMC	R-I-F-S						
xtmelogit DichAVBedarf Monarchien WSLiberal WSKonserv WSSozialdemo WSMediterran || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
eststo AME34s

*M5:	CMC	R-I-F-S	
xtmelogit DichAVBedarf Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand ///
BildungNiedrig_cmc BildungHoch_cmc Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc  Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
eststo AME35s
eststo AV3


predict PDev3, deviance 
predict PPear3, pearson 
predict mu3
predict fixed3, xb
				
*M6: 	CMC	R-I-F-S						
xtmelogit DichAVBedarf Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand ///
 BildungNiedrig_cmc BildungHoch_cmc Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc Monarchien WSLiberal WSKonserv WSSozialdemo WSMediterran || Land: if SampleFCA == 1, or var		
estat ic								
margins , dydx (_all) noatlegend
eststo AME36s
esttab AME31s AME32s AME33s AME34s AME35s AME36s using Bedarf.rtf, replace mtitles se(%9.3f) b(%9.3f) 
					



*******************************************************************************
*4. Anrecht
*1. Schritt: Nullmodell (keine prädikatoren)
xtmelogit DichAVAnrecht Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc || Land: if SampleFCA == 1, or var		
estat ic		
estat icc			//ICC: 0,13 --> 13%
*estimates store m11									
margins , dydx (_all) noatlegend
eststo AME41s

*2. Schritt: Random-Intercept, Fixed Slope (Prädikatoren auf Ebene 1&2)					
*M1:
xtmelogit DichAVAnrecht Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc || Land: if SampleFCA == 1, or var		
estat ic										
margins , dydx (_all) noatlegend
eststo AME41s

*M2:	CMC	R-I-F-S	
xtmelogit DichAVAnrecht Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand BildungNiedrig_cmc BildungHoch_cmc || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AME42s

*M3:	CMC	R-I-F-S	
xtmelogit DichAVAnrecht Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
eststo AME43s

*M4:	CMC	R-I-F-S						
xtmelogit DichAVAnrecht Monarchien WSLiberal WSKonserv WSSozialdemo WSMediterran || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
eststo AME44s

*M5:	CMC	R-I-F-S	
xtmelogit DichAVAnrecht Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand ///
BildungNiedrig_cmc BildungHoch_cmc Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc  Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
eststo AME45s
eststo AV4


predict PDev4, deviance 
predict PPear4, pearson 
predict mu4
predict fixed4, xb
				
*M6: 	CMC	R-I-F-S						
xtmelogit DichAVAnrecht Geschlecht_cmc AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc Arbeitslosigkeit_cmc Sozialleistung_cmc EinkommenPercentileLand ///
 BildungNiedrig_cmc BildungHoch_cmc Religion_cmc LinksRechts_cmc trustInst_cmc trustinHumans_cmc satiswithstate_cmc Monarchien WSLiberal WSKonserv WSSozialdemo WSMediterran || Land: if SampleFCA == 1, or var		
estat ic								
margins , dydx (_all) noatlegend
eststo AME46s
esttab AME41s AME42s AME43s AME44s AME45s AME46s using Anrecht.rtf, replace mtitles se(%9.3f) b(%9.3f) 
					
					
********************************************************************************
*2. Robustheitstests
*Gegenüberstellung M6-Full-Case-Analysis und M6-Imputiert für Einkommen/Sozialleistung_cmc

*1. Gleichheit
*M5 SAMPLEIMPUTIERT
xtmelogit DichAVGleichheit Geschlecht_cmc2 AlterJung_cmc2 AlterMittelAlt_cmc2 AlterAlt_cmc2 Arbeitslosigkeit_cmc2 SozialleistungImputiert EinkommenImputiert BildungNiedrig_cmc2 BildungHoch_cmc2 Religion_cmc2 LinksRechts_cmc2 trustInst_cmc2 trustinHumans_cmc2 satiswithstate_cmc2 Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleImputiert == 1, or var	
estat ic					
margins , dydx (_all) noatlegend
eststo AME51s


******************
*2. Leistung

*M5 SAMPLEIMPUTIERT
xtmelogit DichAVLeistung Geschlecht_cmc2 AlterJung_cmc2 AlterMittelAlt_cmc2 AlterAlt_cmc2 Arbeitslosigkeit_cmc2 SozialleistungImputiert EinkommenImputiert BildungNiedrig_cmc2 BildungHoch_cmc2 Religion_cmc2 LinksRechts_cmc2 trustInst_cmc2 trustinHumans_cmc2 satiswithstate_cmc2 Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleImputiert == 1, or var	
estat ic					
margins , dydx (_all) noatlegend
eststo AME61s


******************
*3. Bedarf
*M5 SAMPLEIMPUTIERT
xtmelogit DichAVBedarf Geschlecht_cmc2 AlterJung_cmc2 AlterMittelAlt_cmc2 AlterAlt_cmc2 Arbeitslosigkeit_cmc2 SozialleistungImputiert EinkommenImputiert BildungNiedrig_cmc2 BildungHoch_cmc2 Religion_cmc2 LinksRechts_cmc2 trustInst_cmc2 trustinHumans_cmc2 satiswithstate_cmc2 Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleImputiert == 1, or var	
estat ic					
margins , dydx (_all) noatlegend
eststo AME71s


******************
*4. Anrecht
*M5 SAMPLEIMPUTIERT
xtmelogit DichAVAnrecht Geschlecht_cmc2 AlterJung_cmc2 AlterMittelAlt_cmc2 AlterAlt_cmc2 Arbeitslosigkeit_cmc2 SozialleistungImputiert EinkommenImputiert BildungNiedrig_cmc2 BildungHoch_cmc2 Religion_cmc2 LinksRechts_cmc2 trustInst_cmc2 trustinHumans_cmc2 satiswithstate_cmc2 Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleImputiert == 1, or var	
estat ic					
margins , dydx (_all) noatlegend
eststo AME81s
*Gegenüberstellung
esttab AME51s AME61s AME71s AME81s using Robustheitstests.rtf, replace mtitles se(%9.3f) b(%9.3f) 

				
*********************************************************
*Tabellen Modell 4 je nach Referenzgruppe
*Wurde für jede der vier AVs durchgeführt und die entsprechenden Signifikanzen verwendet
*Lib
xtmelogit DichAVAnrecht Monarchien WSKonserv WSSozialdemo WSMediterran WSOsten || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
*Konserv
xtmelogit DichAVAnrecht Monarchien WSLiberal WSSozialdemo WSMediterran WSOsten || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
*Sozial
xtmelogit DichAVAnrecht Monarchien WSLiberal WSKonserv WSMediterran WSOsten || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
*Mediterr
xtmelogit DichAVAnrecht Monarchien WSLiberal WSKonserv WSSozialdemo WSOsten || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend
*Osten			
xtmelogit DichAVAnrecht Monarchien WSLiberal WSKonserv WSSozialdemo WSMediterran || Land: if SampleFCA == 1, or var		
estat ic
margins , dydx (_all) noatlegend

				
save $data/ESS5.dta, replace
