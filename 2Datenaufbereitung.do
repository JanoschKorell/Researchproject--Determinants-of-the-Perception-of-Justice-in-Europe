*Masterforschungsprojekt
*WiSe 2021/22
*Datenaufbereitung

capture log close
use $data/ESS1, clear
log using $lofi/LogFileDatenaufbereitung, replace
set more off, perm
numlabel _all, add force

********************************************************************************
*In diesem DoFile wird durchgeführt:
*1. Ländervariable								
*2. Datenaufbereitung UVs Mikro					 
*	1. Geschlecht								 
*	2. Alter									
*			Dichotomisierung					 
*	3. Erwerbssituation							 
*	4. Einkommen							 
*			Percentile						 
*	5. Bildung									 
*			Dichotomisierung				 
*	6. Empfänger von Sozialhilfen				 
*	7. Religion									 
*	8. Politische Einstellung					 
*	9. Politische Bewertung	Trust				 
*   10.Politische Bewertung Satisfied			 
*	11.Vertrauen zu anderen Menschen			 
*3. Datenaufbereitung AVs						 
*	1. Gleichheit								 	
*	2. Leistung									 
*	3. Bedarf									 
*	4. Anrecht									 
*4. Datenaufbereitung UVs Makrovar				 
*	1. Wohlfahrtsstaatstypen					 
*	2. BIP/Kopf									
*	3. Gini-Index								 
* 	4. Sozialausgaben					
*		1. Sozialausgaben
*		2. Sozialausgaben Geteilt
*	5. Arbeitslosigkeitsquote					 
********************************************************************************

********************************************************************************
*1. Ländervariable

tab cntry
gen Land = .
replace Land = 0 if cntry == "AT"
replace Land = 1 if cntry == "BE"
replace Land = 2 if cntry == "BG"
replace Land = 3 if cntry == "CH"
replace Land = 4 if cntry == "CY"
replace Land = 5 if cntry == "CZ"
replace Land = 6 if cntry == "DE"
replace Land = 7 if cntry == "DK"
replace Land = 8 if cntry == "EE"
replace Land = 9 if cntry == "ES"
replace Land = 10 if cntry == "FI"
replace Land = 11 if cntry == "FR"
replace Land = 12 if cntry == "GB"
replace Land = 13 if cntry == "HR"
replace Land = 14 if cntry == "HU"
replace Land = 15 if cntry == "IE"
replace Land = 16 if cntry == "IS"
replace Land = 17 if cntry == "IT"
replace Land = 18 if cntry == "LT"
replace Land = 19 if cntry == "LV"
replace Land = 20 if cntry == "ME"
replace Land = 21 if cntry == "NL"
replace Land = 22 if cntry == "NO"
replace Land = 23 if cntry == "PL"
replace Land = 24 if cntry == "PT"
replace Land = 25 if cntry == "RS"
replace Land = 26 if cntry == "SE"
replace Land = 27 if cntry == "SI"
replace Land = 28 if cntry == "SK"
lab de Land 0 "AT" 1 "BE" 2 "BG" 3 "CH" 4 "CY" 5 "CZ" 6 "DE" 7 "DK" 8 "EE" 9 "ES" 10 "FI" 11 "FR" 12 "GB" 13 "HR" 14 "HU" 15 "IE" 16 "IS" 17 "IT" 18 "LT" 19 "LV" 20 "ME" 21 "NL" 22 "NO" 23 "PL" 24 "PT" 25 "RS" 26 "SE" 27 "SI" 28 "SK"
lab val Land Land
tab Land


********************************************************************************
*2. Datenaufbereitung

*UVs Mikro
*2.1 Geschlecht	
tab gndr, m 		//49.519 Gültige Fälle
					//Keine Missings
					//1 Mann
					//2 Frau
recode gndr (1 = 0)(2 = 1), gen (Geschlecht)
lab de Geschlecht 0 "Mann" 1 "Frau"
lab val Geschlecht Geschlecht
tab Geschlecht, m 


******************************
*2.2 Alter			
tab agea, m			//49,297 Gültige Fälle
					//222 Missings
					//Metrisch
gen Alter = 1		//Kohorten:				  1 = 25-44
replace Alter = 0 if agea < 25				//0 = 0-24
replace Alter = 2 if agea >= 45 & agea < 65	//2 = 45-64
replace Alter = 3 if agea >= 65				//3 = 65+
replace Alter = . if agea == .d
lab de Alter 0 "0-24" 1 "25-44" 2 "45-64" 3 "65+"
lab val Alter Alter
tab Alter, m

*Dichotomisierung
recode Alter (0 = 1) (1 = 0) (2 = 0) (3 = 0), gen (AlterJung)
recode Alter (1 = 1) (0 = 0) (2 = 0) (3 = 0), gen (AlterMittelJung)
recode Alter (2 = 1) (1 = 0) (0 = 0) (3 = 0), gen (AlterMittelAlt)
recode Alter (3 = 1) (1 = 0) (2 = 0) (0 = 0), gen (AlterAlt)	
lab values AlterJung AlterMittelJung AlterMittelAlt AlterAlt NeinJa
tab1 AlterJung AlterMittelJung AlterMittelAlt AlterAlt, m		


******************************		
*2.3 Erwerbssituation
*Für drei Monate oder mehr
tab uemp3m, m		//49,224 Gültige Fälle
					//295 Missings
					//1 Yes
					//2 No
					//Anderen Erwebslosigkeitsvariablen sind deutlich unaufgeteilter
					//.b .c .d als Missings --> Generate
gen Arbeitslosigkeit = .
replace Arbeitslosigkeit = 1 if uemp3m == 1
replace Arbeitslosigkeit = 0 if uemp3m == 2
lab de NeinJa 0 "Nein" 1 "Ja"
tab Arbeitslosigkeit, m


******************************
*2.4 Einkommen	
	*Haushaltseinkommen (hinctnta, in Decilen)
	*ODER
	*Gross Pay (grspnum)
	*ODER
	*Your usual net (netinum)
	*Alles nach Weekly/Monthly/Annula siehe (infqbst)

tab infqbst			//42,340 gültige Werte
					//1 Weekly
					//2 Monthly
					//3 Annual

sum hinctnta		//39,865 Gültige Werte
sum grspnum			//18,271 Gültige Werte
sum netinum			//32,837 Gültige Werte
tab netinum, m		// Not applicable 4,695
sum netinum if infqbst == 1
sum netinum if infqbst == 2
sum netinum if infqbst == 3
gen Einkommen = .
replace Einkommen = netinum if infqbst == 2
replace Einkommen = netinum * 4 if infqbst == 1
replace Einkommen = netinum / 12 if infqbst == 3
tab Einkommen
sum Einkommen, d	//Muss nach Perzentilen pro Land programmiert werden!
					//Dezile
					tab agea if Einkommen == .
					//Missings können nicht auf das Alter zurückgeführt werden.
*Perzentile pro Land
ssc install egenmore //Package um Percentile nach Gruppe simple zu programmieren
egen EinkommenPercentileLand = xtile(Einkommen), n(10) by(Land)
recode EinkommenPercentileLand (1=0)(2=1)(3=2)(4=3)(5=4)(6=5)(7=6)(8=7)(9=8)(10=9)
tab EinkommenPercentileLand, m 

*Kontrolle Perzentile pro Land
tab EinkommenPercentileLand if Land == 1
tab EinkommenPercentileLand if Land == 2
sum Einkommen if Land == 1, d 
tab EinkommenPercentileLand if Einkommen == 600 & Land == 1
tab EinkommenPercentileLand if Einkommen == 600
tab Land if Einkommen == 600 & EinkommenPercentileLand == 9
sum Einkommen if Land == 20, d
tab Einkommen if Land == 20		
//Mit einem Einkommen von 600 ist man nach Perzentilen in einem Land in der letzten, und in ME (Montenegro) in der ersten Gruppe
//Aber inhaltlich scheint die Variable plausibel


******************************
*2.5 Bildung				
*Highest level of Education ISCED
tab eisced			//49,245 Gültige Werte
					//Ausschluss von 167 Fällen, die "Other" angeben
gen BildungsstufeQuasimetr = eisced if eisced <= 7 //Missings
recode BildungsstufeQuasimetr (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6)
lab de BildungsstufeQuasimetr 0 " less than lowerSecondary" 1 "lowerSecondary" 2 "lower upper secondary" 3 "upper upper secondary" 4 "advanced vocational" 5 "lower tertiary" 6 "higher tertiary"
tab BildungsstufeQuasimetr, m		
			
*Dreiteilung nach Eurostat: https://appsso.eurostat.ec.europa.eu/nui/show.do?dataset=edat_lfse_04&lang=en
	*0-2 *3-4 *5-6
recode BildungsstufeQuasimetr (0=0) (1=0) (2=0) (3=1) (4=1) (5=2) (6=2), gen (BildungsstufeDreiteilung)
label def BildungsstufeDreiteilung 0 "Bildung Niedrig" 1 "Bildung Mittel" 2 "Bildung Hoch"
label values BildungsstufeDreiteilung BildungsstufeDreiteilung
tab BildungsstufeDreiteilung, m

*Dichotomisierung:
recode BildungsstufeDreiteilung (0 = 1) (1 = 0) (2 = 0), gen (BildungNiedrig)
recode BildungsstufeDreiteilung (1 = 1) (0 = 0) (2 = 0), gen (BildungMittel)
recode BildungsstufeDreiteilung (2 = 1) (1 = 0) (0 = 0), gen (BildungHoch)
lab values BildungNiedrig BildungMittel BildungHoch	NeinJa
tab1 BildungNiedrig BildungMittel BildungHoch, m	



******************************
*2.6 Hauptquelle des Einkommens: Sozialleistung
tab iincsrc, m		//37,709 Gültige Fälle
					//11,810 Missings
					//1-3 Lohn oder Selbstständig
					//7 Investments
					//8 Anderes
					//9 Kein Einkommen
					//4 Rente
					//5 Arbeitslosigkeitsunterstützung
					//6 Andere Sozialleistung
recode iincsrc (1 = 0) (2 = 0) (3 = 0) (7 = 0) (8 = 0) (9 = 0) (4 = 1) (5 = 1) (6 = 1), gen (Sozialleistung)
lab var Sozialleistung NeinJa
tab Sozialleistung, m


******************************
*2.7 Religion 			
tab rlgblg, m		//49,161 Gültige Werte
					//358 Missings
					//1 Ja
					//2 Nein
recode rlgblg (2 = 0) (1 = 1), gen (Religion)					
label def Religion 0 "Nein" 1 "Ja", modify	
label values Religion Religion
tab Religion


******************************
*2.8 Politische Einstellung
tab lrscale, m			//42,269 Gültige Werte
						//.b. .c. .d. missings
recode lrscale (0 = 0) (1 = 1) (2 = 2) (3 = 3) (4 = 4) (5 = 5) (6 = 6) (7 = 7) (8 = 8) (9 = 9)(10 = 10), gen (LinksRechts)
lab de LinksRechts 0 "Links" 10 "Rechts"
lab val LinksRechts LinksRechts
tab LinksRechts			//42,269 Gültige Werte


******************************
*2.9 Vertrauen in Institutionen
foreach var of varlist trstprl trstlgl trstplt trstprt{
replace `var'= . if `var' == .a  |  `var' == .b  | `var' == .c  |  `var' == .d
tab `var', m
}
factor  trstprl trstlgl trstplt trstprt
screeplot
alpha   trstprl trstlgl trstplt trstprt, casewise item detail std
gen trustInst = (trstprl+trstlgl+trstplt+trstprt)/4
tab trustInst, m


******************************
*2.10 Vertrauen in andere Menschen Index
tab1 ppltrst pplfair pplhlp,m 
foreach var of varlist ppltrst pplfair pplhlp {
replace `var'= . if `var' == .a  |  `var' == .b  | `var' == .c  |  `var' == .d
tab `var', m
}
factor   ppltrst pplfair pplhlp
screeplot
alpha   ppltrst pplfair pplhlp, casewise item detail std
gen trustinHumans = (ppltrst+pplfair+pplhlp)/3
tab trustinHumans, m


******************************
*2.11 Zufrieden mit Regierung, Demokratie Index
tab1 stfgov stfdem, m
foreach var of varlist stfgov stfdem  {
replace `var'= . if `var' == .a  |  `var' == .b  | `var' == .c  |  `var' == .d
tab `var', m
}
factor   stfgov stfdem
screeplot
alpha   stfgov stfdem, casewise item detail std
gen satiswithstate = (stfgov+stfdem)/2
tab satiswithstate, m


********************************************************************************
*AVs
*"Dont know" = Missing (Es wäre möglich "Dont know" als "Nein" zu definieren.)
*3.1 Gleichheit		
tab sofrdst, m
recode sofrdst (1 = 1) (2 = 1) (3 = 0) (4 = 0) (5 = 0), gen (DichAVGleichheit)
lab var DichAVGleichheit NeinJa
tab DichAVGleichheit, m			//48.386 Gültige Werte


******************************
*3.2 Leistung
tab sofrwrk, m
recode sofrwrk (1 = 1) (2 = 1) (3 = 0) (4 = 0) (5 = 0), gen (DichAVLeistung)
lab var DichAVLeistung NeinJa
tab DichAVLeistung, m			//48.606 Gültige Werte


******************************
*3.3 Bedarf
tab sofrpr, m
recode sofrpr (1 = 1) (2 = 1) (3 = 0) (4 = 0) (5 = 0), gen (DichAVBedarf)
lab var DichAVBedarf NeinJa
tab DichAVBedarf, m				//48.473 Gültige Werte


******************************
*3.4 Anrecht
tab sofrprv, m 
recode sofrprv (1 = 1) (2 = 1) (3 = 0) (4 = 0) (5 = 0), gen (DichAVAnrecht)
lab var DichAVAnrecht NeinJa
tab DichAVAnrecht, m			//47.703 Gültige Werte


********************************************************************************
*4. UVs Makro

******************************
*4.1 Wohlfahrtsstaatstypen
gen Wohlfahrtsstaaten = .
replace Wohlfahrtsstaaten = 1 if Land == 15 | Land == 12
		// Liberaler WS Irland, GB
replace Wohlfahrtsstaaten = 2 if Land == 6	| Land == 11 | Land == 1 | Land == 21 | Land == 3 | Land == 0											
		// Bismarck/Konservativer WS Deutschland, Frankreich, Belgien, Niederlande, Luxemburg???, Schweiz, Austria
replace Wohlfahrtsstaaten = 3 if Land == 26 | Land == 7  | Land == 10 | Land == 22	| Land == 16 																	
		// Skandinavischer/Sozialdemokratischer WS Schweden, Dänemark, Finnland, Norwegen, Island (16)
replace Wohlfahrtsstaaten = 4 if Land == 17 | Land == 9	 | Land == 24 | Land == 4	
		// Mediterraner WS Griechenland???, Italien, Spanien, Portugal, Zypern
replace Wohlfahrtsstaaten = 5 if Land == 5	| Land == 8	 | Land == 14 | Land == 19 | Land == 18 | Land == 23 | Land == 28 | Land == 27 | Land == 2 | Land == 13	| Land == 20 | Land == 25	
		// Osten Czech Republic, Estonia, Hungary, Latvia, Lithuania, Poland, Slovakia, Slovenia, Bulgarien (2), Kroatien (13), Montenegro (20), Serbien (25)


label values Wohlfahrtsstaaten Wohlfahrtsstaaten
label def Wohlfahrtsstaaten 1 "Liberaler WS", modify
label def Wohlfahrtsstaaten 2 "Bismarck/Konservativer WS", modify	
label def Wohlfahrtsstaaten 3 "Skandinavischer/Sozialdemokratischer WS", modify	
label def Wohlfahrtsstaaten 4 "Mediterraner WS", modify	
label def Wohlfahrtsstaaten 5 "Osten", modify	
	

tab Wohlfahrtsstaaten

*Dichotomisierung
gen WSLiberal = Wohlfahrtsstaaten
recode WSLiberal (2 3 4 5  = 0) (1 = 1)

gen WSKonserv = Wohlfahrtsstaaten
recode WSKonserv (1 3 4 5  = 0) (2 = 1)

gen WSSozialdemo = Wohlfahrtsstaaten
recode WSSozialdemo (2 1 4 5  = 0) (3 = 1)

gen WSMediterran = Wohlfahrtsstaaten
recode WSMediterran (2 3 1 5  = 0) (4 = 1)

gen WSOsten = Wohlfahrtsstaaten
recode WSOsten (2 3 4 1  = 0) (5 = 1)

tab1 WSLiberal WSKonserv WSSozialdemo WSMediterran WSOsten


******************************
*4.2 BIP/Kopf
*In tausend
gen BipKopf2 = .
replace BipKopf2 = 35  if Land == 0
replace BipKopf2 = 34 if Land == 1
replace BipKopf2 = 6 if Land == 2
replace BipKopf2 = 61 if Land == 3
replace BipKopf2 = 24 if Land == 4
replace BipKopf2 = 17 if Land == 5
replace BipKopf2 = 34 if Land == 6
replace BipKopf2 = 48 if Land == 7
replace BipKopf2 = 15 if Land == 8
replace BipKopf2 = 22 if Land == 9
replace BipKopf2 = 36 if Land == 10
replace BipKopf2 = 31 if Land == 11
replace BipKopf2 = 33 if Land == 12
replace BipKopf2 = 12 if Land == 13
replace BipKopf2 = 13 if Land == 14
replace BipKopf2 = 63 if Land == 15
replace BipKopf2 = 36 if Land == 16
replace BipKopf2 = 25 if Land == 17
replace BipKopf2 = 14 if Land == 18
replace BipKopf2 = 12 if Land == 19
replace BipKopf2 = 5 if Land == 20
replace BipKopf2 = 40 if Land == 21
replace BipKopf2 = 69 if Land == 22
replace BipKopf2 = 13 if Land == 23
replace BipKopf2 = 17 if Land == 24
replace BipKopf2 = 5 if Land == 25
replace BipKopf2 = 43 if Land == 26
replace BipKopf2 = 20 if Land == 27
replace BipKopf2 = 15 if Land == 28
tab BipKopf2


******************************
*4.3 Gini-Index
gen GiniIndex = .
replace GiniIndex = 30.8 if Land == 0
replace GiniIndex = 27.2 if Land == 1
replace GiniIndex = 41.3 if Land == 2
replace GiniIndex = 33.1 if Land == 3
replace GiniIndex = 32.7 if Land == 4
replace GiniIndex = 25 if Land == 5
replace GiniIndex = 31.9 if Land == 6 
replace GiniIndex = 28.2 if Land == 7
replace GiniIndex = 30.3 if Land == 8
replace GiniIndex = 34.7 if Land == 9
replace GiniIndex = 27.3 if Land == 10
replace GiniIndex = 32.4 if Land == 11
replace GiniIndex = 35.1 if Land == 12
replace GiniIndex = 29.7 if Land == 13
replace GiniIndex = 29.6 if Land == 14
replace GiniIndex = 31.4 if Land == 15
replace GiniIndex = 26.1 if Land == 16
replace GiniIndex = 35.9 if Land == 17
replace GiniIndex = 35.7 if Land == 18
replace GiniIndex = 35.1 if Land == 19
replace GiniIndex = 38.5 if Land == 20
replace GiniIndex = 28.1 if Land == 21
replace GiniIndex = 27.6 if Land == 22
replace GiniIndex = 30.2 if Land == 23
replace GiniIndex = 33.5 if Land == 24
replace GiniIndex = 36.2 if Land == 25
replace GiniIndex = 30 if Land == 26
replace GiniIndex = 24.6 if Land == 27
replace GiniIndex = 25 if Land == 28
tab GiniIndex 


******************************
*4.4 Sozialausgaben
*In tausend
gen Sozialausgaben2 = .
replace Sozialausgaben2 = 13.1 if Land == 0
replace Sozialausgaben2 = 12.0 if Land == 1
replace Sozialausgaben2 = 1.5 if Land == 2
replace Sozialausgaben2 = 20.5 if Land == 3
replace Sozialausgaben2 = 4.7 if Land == 4
replace Sozialausgaben2 = 4.0 if Land == 5
replace Sozialausgaben2 = 12.6 if Land == 6
replace Sozialausgaben2 = 16.9 if Land == 7
replace Sozialausgaben2 = 3.5 if Land == 8
replace Sozialausgaben2 = 6.4 if Land == 9
replace Sozialausgaben2 = 13.1 if Land == 10
replace Sozialausgaben2 = 12.2 if Land == 11
replace Sozialausgaben2 = 9.4 if Land == 12
replace Sozialausgaben2 = 2.9 if Land == 13
replace Sozialausgaben2 = 2.4 if Land == 14
replace Sozialausgaben2 = 9.8 if Land == 15
replace Sozialausgaben2 = 15.1 if Land == 16
replace Sozialausgaben2 = 8.7 if Land == 17
replace Sozialausgaben2 = 2.9 if Land == 18
replace Sozialausgaben2 = 2.5 if Land == 19
replace Sozialausgaben2 = 1.2 if Land == 20
replace Sozialausgaben2 = 13.5 if Land == 21
replace Sozialausgaben2 = 18.6 if Land == 22
replace Sozialausgaben2 = 3.0 if Land == 23
replace Sozialausgaben2 = 5.0 if Land == 24
replace Sozialausgaben2 = 1.2 if Land == 25
replace Sozialausgaben2 = 12.8 if Land == 26
replace Sozialausgaben2 = 5.1 if Land == 27
replace Sozialausgaben2 = 3.1 if Land == 28
tab Sozialausgaben2
*Geteilt durch Bip/Kopf
gen SozialausgabenGeteilt = Sozialausgaben2 / BipKopf2
tab SozialausgabenGeteilt

******************************
*4.5 Arbeitslosigkeitsquote
gen Arbeitslosigkeitsquote = .
replace Arbeitslosigkeitsquote = 5.3 if Land == 0
replace Arbeitslosigkeitsquote = 5.9 if Land == 1
replace Arbeitslosigkeitsquote = 5.0 if Land == 2
replace Arbeitslosigkeitsquote = 4.9 if Land == 3
replace Arbeitslosigkeitsquote = 6.4 if Land == 4
replace Arbeitslosigkeitsquote = 2.2 if Land == 5
replace Arbeitslosigkeitsquote = 3.2 if Land == 6
replace Arbeitslosigkeitsquote = 5.0 if Land == 7
replace Arbeitslosigkeitsquote = 5.0 if Land == 8
replace Arbeitslosigkeitsquote = 14.1 if Land == 9
replace Arbeitslosigkeitsquote = 7.2 if Land == 10
replace Arbeitslosigkeitsquote = 7.5 if Land == 11
replace Arbeitslosigkeitsquote = 4.4 if Land == 12
replace Arbeitslosigkeitsquote = 7.1 if Land == 13
replace Arbeitslosigkeitsquote = 3.8 if Land == 14
replace Arbeitslosigkeitsquote = 5.1 if Land == 15
replace Arbeitslosigkeitsquote = 3.6 if Land == 16
replace Arbeitslosigkeitsquote = 9.2 if Land == 17
replace Arbeitslosigkeitsquote = 6.0 if Land == 18
replace Arbeitslosigkeitsquote = 7.3 if Land == 19
replace Arbeitslosigkeitsquote = 15.9 if Land == 20
replace Arbeitslosigkeitsquote = 3.8 if Land == 21
replace Arbeitslosigkeitsquote = 3.6 if Land == 22
replace Arbeitslosigkeitsquote = 3.0 if Land == 23
replace Arbeitslosigkeitsquote = 6.3 if Land == 24
replace Arbeitslosigkeitsquote = 9.1 if Land == 25
replace Arbeitslosigkeitsquote = 8.0 if Land == 26
replace Arbeitslosigkeitsquote = 4.8 if Land == 27
replace Arbeitslosigkeitsquote = 6.3 if Land == 28
tab Arbeitslosigkeitsquote


******************************
*4.6 Monarchien (De Jure Monarchien in der Staatsform)
gen Monarchien = 0
replace Monarchien = 1 if Land == 1 	//Belgien
replace Monarchien = 1 if Land == 9 	//Spanien
replace Monarchien = 1 if Land == 21 	//Niederlande
replace Monarchien = 1 if Land == 12 	//Grossbritannien
replace Monarchien = 1 if Land == 26 	//Schweden
replace Monarchien = 1 if Land == 22 	//Norwegen
replace Monarchien = 1 if Land == 7 	//Dänemark
tab Monarchien


save $data/ESS2.dta, replace
