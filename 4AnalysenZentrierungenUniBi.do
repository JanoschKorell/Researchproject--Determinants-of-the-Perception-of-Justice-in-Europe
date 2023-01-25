*Masterforschungsprojekt
*WiSe 2021/22
*Zentrierung Uni+Bivariate Analysen

capture log close
use $data/ESS3, clear
log using $lofi/LogFileAnalysenZentrierungUniBi, replace
set more off, perm
numlabel _all, add force

********************************************************************************
*In diesem DoFile wird durchgeführt:
*1. Zentrierungen
* 	1. Zentrierung aller UVs fürs SampleFCA (Standardanalysen)
* 	2. Zentrierung aller UVs fürs SampleImputiert (Robustheitstests)
*2. Univariate Analyse aller Variablen
*3. Bivariate Koeffizienten
*4. Bivariate Graphiken: Jede UV vs. AV
********************************************************************************

*1.1 Zentrierung aller UVs fürs SampleFCA (Standardanalysen)
*CMC für alle lvl 1 UVs exkl. EinkommenPercentileLand (-> Schon Zentriert durch die länderspezifischen Perzentile)
sort Land
by Land: egen cluster_mean_Geschlecht = mean(Geschlecht) if SampleFCA == 1
gen Geschlecht_cmc = Geschlecht - cluster_mean_Geschlecht if SampleFCA == 1
tab Geschlecht_cmc

sort Land
by Land: egen cluster_mean_AlterJung = mean(AlterJung) if SampleFCA == 1
gen AlterJung_cmc = AlterJung - cluster_mean_AlterJung if SampleFCA == 1
tab AlterJung_cmc

sort Land
by Land: egen cluster_mean_AlterMittelAlt = mean(AlterMittelAlt) if SampleFCA == 1
gen AlterMittelAlt_cmc = AlterMittelAlt - cluster_mean_AlterMittelAlt if SampleFCA == 1
tab AlterMittelAlt_cmc

sort Land
by Land: egen cluster_mean_AlterAlt = mean(AlterAlt) if SampleFCA == 1
gen AlterAlt_cmc = AlterAlt - cluster_mean_AlterAlt if SampleFCA == 1
tab AlterAlt_cmc

sort Land
by Land: egen cluster_mean_BildungNiedrig = mean(BildungNiedrig) if SampleFCA == 1
gen BildungNiedrig_cmc = BildungNiedrig - cluster_mean_BildungNiedrig if SampleFCA == 1
tab BildungNiedrig_cmc

sort Land
by Land: egen cluster_mean_BildungHoch = mean(BildungHoch) if SampleFCA == 1
gen BildungHoch_cmc = BildungHoch - cluster_mean_BildungHoch if SampleFCA == 1
tab BildungHoch_cmc

sort Land
by Land: egen cluster_mean_Arbeitslosigkeit = mean(Arbeitslosigkeit) if SampleFCA == 1
gen Arbeitslosigkeit_cmc = Arbeitslosigkeit - cluster_mean_Arbeitslosigkeit if SampleFCA == 1
tab Arbeitslosigkeit_cmc

sort Land
by Land: egen cluster_mean_Sozialleistung = mean(Sozialleistung) if SampleFCA == 1
gen Sozialleistung_cmc = Sozialleistung - cluster_mean_Sozialleistung if SampleFCA == 1
tab Sozialleistung_cmc

sort Land
by Land: egen cluster_mean_Religion = mean(Religion) if SampleFCA == 1
gen Religion_cmc = Religion - cluster_mean_Religion if SampleFCA == 1
tab Religion_cmc

sort Land
by Land: egen cluster_mean_LinksRechts = mean(LinksRechts) if SampleFCA == 1
gen LinksRechts_cmc = LinksRechts - cluster_mean_LinksRechts if SampleFCA == 1
tab LinksRechts_cmc

sort Land
by Land: egen cluster_mean_trustInst = mean(trustInst) if SampleFCA == 1
gen trustInst_cmc = trustInst - cluster_mean_trustInst if SampleFCA == 1
tab trustInst_cmc

sort Land
by Land: egen cluster_mean_trustinHumans = mean(trustinHumans) if SampleFCA == 1
gen trustinHumans_cmc = trustinHumans - cluster_mean_trustinHumans if SampleFCA == 1
tab trustinHumans_cmc

sort Land
by Land: egen cluster_mean_satiswithstate = mean(satiswithstate) if SampleFCA == 1
gen satiswithstate_cmc = satiswithstate - cluster_mean_satiswithstate if SampleFCA == 1
tab satiswithstate_cmc


******************
*1.2 Zentrierung aller UVs fürs SampleImputiert (Robustheitstests)
*CMC für alle lvl 1 UVs exkl. EinkommenPercentileLand (-> Schon Zentriert durch die länderspezifischen Perzentile)
sort Land
by Land: egen cluster_mean_Geschlecht2 = mean(Geschlecht) if SampleImputiert == 1
gen Geschlecht_cmc2 = Geschlecht - cluster_mean_Geschlecht2 if SampleImputiert == 1
tab Geschlecht_cmc2

sort Land
by Land: egen cluster_mean_AlterJung2 = mean(AlterJung) if SampleImputiert == 1
gen AlterJung_cmc2 = AlterJung - cluster_mean_AlterJung2 if SampleImputiert == 1
tab AlterJung_cmc2

sort Land
by Land: egen cluster_mean_AlterMittelAlt2 = mean(AlterMittelAlt) if SampleImputiert == 1
gen AlterMittelAlt_cmc2 = AlterMittelAlt - cluster_mean_AlterMittelAlt2 if SampleImputiert == 1
tab AlterMittelAlt_cmc2

sort Land
by Land: egen cluster_mean_AlterAlt2 = mean(AlterAlt) if SampleImputiert == 1
gen AlterAlt_cmc2 = AlterAlt - cluster_mean_AlterAlt2 if SampleImputiert == 1
tab AlterAlt_cmc2

sort Land
by Land: egen cluster_mean_BildungNiedrig2 = mean(BildungNiedrig) if SampleImputiert == 1
gen BildungNiedrig_cmc2 = BildungNiedrig - cluster_mean_BildungNiedrig2 if SampleImputiert == 1
tab BildungNiedrig_cmc2

sort Land
by Land: egen cluster_mean_BildungHoch2 = mean(BildungHoch) if SampleImputiert == 1
gen BildungHoch_cmc2 = BildungHoch - cluster_mean_BildungHoch2 if SampleImputiert == 1
tab BildungHoch_cmc2

sort Land
by Land: egen cluster_mean_Arbeitslosigkeit2 = mean(Arbeitslosigkeit) if SampleImputiert == 1
gen Arbeitslosigkeit_cmc2 = Arbeitslosigkeit - cluster_mean_Arbeitslosigkeit2 if SampleImputiert == 1
tab Arbeitslosigkeit_cmc2

sort Land
by Land: egen cluster_mean_Sozialleistung2 = mean(Sozialleistung) if SampleImputiert == 1
gen Sozialleistung_cmc2 = Sozialleistung - cluster_mean_Sozialleistung2 if SampleImputiert == 1
tab Sozialleistung_cmc2

sort Land
by Land: egen cluster_mean_Religion2 = mean(Religion) if SampleImputiert == 1
gen Religion_cmc2 = Religion - cluster_mean_Religion2 if SampleImputiert == 1
tab Religion_cmc2

sort Land
by Land: egen cluster_mean_LinksRechts2 = mean(LinksRechts) if SampleImputiert == 1
gen LinksRechts_cmc2 = LinksRechts - cluster_mean_LinksRechts2 if SampleImputiert == 1
tab LinksRechts_cmc2

sort Land
by Land: egen cluster_mean_trustInst2 = mean(trustInst) if SampleImputiert == 1
gen trustInst_cmc2 = trustInst - cluster_mean_trustInst2 if SampleImputiert == 1
tab trustInst_cmc2

sort Land
by Land: egen cluster_mean_trustinHumans2 = mean(trustinHumans) if SampleImputiert == 1
gen trustinHumans_cmc2 = trustinHumans - cluster_mean_trustinHumans2 if SampleImputiert == 1
tab trustinHumans_cmc2

sort Land
by Land: egen cluster_mean_satiswithstate2 = mean(satiswithstate) if SampleImputiert == 1
gen satiswithstate_cmc2 = satiswithstate - cluster_mean_satiswithstate2 if SampleImputiert == 1
tab satiswithstate_cmc2



********************************************************************************
*3. Univariate Analyse aller Variablen
*1.1 AVs
tab DichAVGleichheit if SampleFCA == 1
tab DichAVLeistung if SampleFCA == 1
tab DichAVBedarf if SampleFCA == 1
tab DichAVAnrecht if SampleFCA == 1

*UVs Mikroebene
tab Geschlecht if SampleFCA == 1
tab AlterJung if SampleFCA == 1
tab AlterMittelJung if SampleFCA == 1
tab AlterMittelAlt if SampleFCA == 1
tab AlterAlt if SampleFCA == 1
tab Arbeitslosigkeit if SampleFCA == 1
tab Sozialleistung if SampleFCA == 1
tab BildungNiedrig if SampleFCA == 1
tab BildungMittel if SampleFCA == 1
tab BildungHoch if SampleFCA == 1
tab Religion if SampleFCA == 1

sum LinksRechts if SampleFCA == 1
sum LinksRechts if SampleFCA == 1, d
sum trustInst if SampleFCA == 1
sum trustInst if SampleFCA == 1, d
sum trustinHumans if SampleFCA == 1
sum trustinHumans if SampleFCA == 1, d
sum satiswithstate if SampleFCA == 1
sum satiswithstate if SampleFCA == 1, d
sum Einkommen if SampleFCA == 1
sum Einkommen if SampleFCA == 1, d


********************************************************************************
*4. Bivariate Koeffizienten
xtmelogit DichAVGleichheit Geschlecht_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVLeistung Geschlecht_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVBedarf Geschlecht_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVAnrecht Geschlecht_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend

xtmelogit DichAVGleichheit AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVLeistung AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVBedarf AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVAnrecht AlterJung_cmc AlterMittelAlt_cmc AlterAlt_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend

xtmelogit DichAVGleichheit Arbeitslosigkeit_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVLeistung Arbeitslosigkeit_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVBedarf Arbeitslosigkeit_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVAnrecht Arbeitslosigkeit_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend

xtmelogit DichAVGleichheit Sozialleistung_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVLeistung Sozialleistung_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVBedarf Sozialleistung_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVAnrecht Sozialleistung_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend

xtmelogit DichAVGleichheit EinkommenPercentileLand || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVLeistung EinkommenPercentileLand || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVBedarf EinkommenPercentileLand || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVAnrecht EinkommenPercentileLand || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend

xtmelogit DichAVGleichheit BildungNiedrig_cmc BildungHoch_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVLeistung BildungNiedrig_cmc BildungHoch_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVBedarf BildungNiedrig_cmc BildungHoch_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVAnrecht BildungNiedrig_cmc BildungHoch_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend

xtmelogit DichAVGleichheit Religion_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVLeistung Religion_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVBedarf Religion_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVAnrecht Religion_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend

xtmelogit DichAVGleichheit LinksRechts_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVLeistung LinksRechts_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVBedarf LinksRechts_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVAnrecht LinksRechts_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend

xtmelogit DichAVGleichheit satiswithstate_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVLeistung satiswithstate_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVBedarf satiswithstate_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVAnrecht satiswithstate_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend

xtmelogit DichAVGleichheit trustInst_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVLeistung trustInst_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVBedarf trustInst_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVAnrecht trustInst_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend

xtmelogit DichAVGleichheit trustinHumans_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVLeistung trustinHumans_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVBedarf trustinHumans_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
xtmelogit DichAVAnrecht trustinHumans_cmc || Land: if SampleFCA == 1, or var
margins , dydx (_all) noatlegend
 
*Bivariat Gleichheit Makroebene
xtmelogit DichAVGleichheit Monarchien || Land: if SampleFCA == 1, or var	
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak11s
xtmelogit DichAVGleichheit WSKonserv WSSozialdemo WSMediterran WSOsten || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak12s
xtmelogit DichAVGleichheit Arbeitslosigkeitsquote || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak13s
xtmelogit DichAVGleichheit GiniIndex || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak14s
xtmelogit DichAVGleichheit BipKopf2 || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak15s
xtmelogit DichAVGleichheit Sozialausgaben2 || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak16s
esttab AMEMak11s AMEMak12s AMEMak13s AMEMak14s AMEMak15s AMEMak16s using BiMakroGleichheit.rtf, replace mtitles se(%9.3f) b(%9.3f) 
   

*Bivariat Leistung Makroebene	
xtmelogit DichAVLeistung Monarchien || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak21s
xtmelogit DichAVLeistung WSKonserv WSSozialdemo WSMediterran WSOsten || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak22s
xtmelogit DichAVLeistung Arbeitslosigkeitsquote || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak23s
xtmelogit DichAVLeistung GiniIndex || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak24s
xtmelogit DichAVLeistung BipKopf2 || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak25s
xtmelogit DichAVLeistung Sozialausgaben2 || Land: if SampleFCA == 1, or var
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak26s
esttab AMEMak21s AMEMak22s AMEMak23s AMEMak24s AMEMak25s AMEMak26s using BiMakroLeistung.rtf, replace mtitles se(%9.3f) b(%9.3f) 

*Bivariat Bedarf Makroebene		
xtmelogit DichAVBedarf Monarchien || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak31s
xtmelogit DichAVBedarf WSKonserv WSSozialdemo WSMediterran WSOsten || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak32s
xtmelogit DichAVBedarf Arbeitslosigkeitsquote || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak33s
xtmelogit DichAVBedarf GiniIndex || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak34s
xtmelogit DichAVBedarf BipKopf2 || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak35s
xtmelogit DichAVBedarf Sozialausgaben2 || Land: if SampleFCA == 1, or var	
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak36s
esttab AMEMak31s AMEMak32s AMEMak33s AMEMak34s AMEMak35s AMEMak36s using BiMakroBedarf.rtf, replace mtitles se(%9.3f) b(%9.3f) 

*Bivariat Anrecht Makroebene
xtmelogit DichAVAnrecht Monarchien || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak41s
xtmelogit DichAVAnrecht WSKonserv WSSozialdemo WSMediterran WSOsten || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak42s
xtmelogit DichAVAnrecht Arbeitslosigkeitsquote || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak43s
xtmelogit DichAVAnrecht GiniIndex || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak44s
xtmelogit DichAVAnrecht BipKopf2 || Land: if SampleFCA == 1, or var		
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak45s
xtmelogit DichAVAnrecht Sozialausgaben2 || Land: if SampleFCA == 1, or var
estat ic	
margins , dydx (_all) noatlegend
eststo AMEMak46s
esttab AMEMak41s AMEMak42s AMEMak43s AMEMak44s AMEMak45s AMEMak46s using BiMakroAnrecht.rtf, replace mtitles se(%9.3f) b(%9.3f) 


save $data/ESS4.dta, replace
