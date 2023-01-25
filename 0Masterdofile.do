*Hausarbeit Quanti ME

*Masterdofile

clear matrix

												
global path "/Users/janoschkorell/Desktop/Wissenschaft/Hausarbeiten_und_Essays_Uni/Quanti Mehrebenen/Mehrebenen_HA/Daten/"
//Janosch	

									
global data $path/Data
global dofi $path/DoFiles
global lofi $path/LogFiles
log using $lofi/LogFileMaster, replace
********************************************************************************
****		DOFILE 1: DATENBEREITSTELLUNG								    ****
********************************************************************************
do $dofi/1Datenbereitstellung
/* EINMALIGE DURCHFÜHRUNG UM SPEICHERPLÄTZE DER DATENSÄTZE ZU MINIMIEREN*/


********************************************************************************
****		DOFILE 2: DATENAUFBEREITUNG									    ****
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
*	5. Arbeitslosigkeitsquote					 
do $dofi/2Datenaufbereitung.do


********************************************************************************
****		DOFILE 3: Missings/SAMPLE									    ****
********************************************************************************
*In diesem DoFile wird durchgeführt:
*1. Betrachtung der Missings (Misstables)	
*	1. Basisvariaben mit wenigen Missings
*	2. Plus Links/Rechts; Religion
*	3. Plus Indizes
*	4. Basis plus problematische Variablen Sozialleistung und Einkommen
*	5. Alle MikroUVs
*2. FlowChart Missings								
*3. Sample 1: Full-Case-Analysis								
*4. Untersuchung MCAR									
*5. Untersuchung metrische Variablen + Transformationen	
*6. Imputation der Mittelwerte								
*7. Sample 2: Robustheitstest  													
do $dofi/3MissingsSample


********************************************************************************
****		DOFILE 4: Zentrierungen, Uni+Bivariate Analysen					****
********************************************************************************
*In diesem DoFile wird durchgeführt:
*1. Zentrierungen
* 	1. Zentrierung aller UVs fürs SampleFCA (Standardanalysen)
* 	2. Zentrierung aller UVs fürs SampleImputiert (Robustheitstests)
*2. Univariate Analyse aller Variablen
*3. Bivariate Koeffizienten
*4. Bivariate Graphiken: Jede UV vs. AV
do $dofi/4AnalysenZentrierungenUniBi


********************************************************************************
****		DOFILE 5: Regressionen								    		****
********************************************************************************
*In diesem DoFile wird durchgeführt:
*1. Regressionen
*2. Robustheitstests
*3. Modell 4 mit verschiedenen Referenzgruppen
do $dofi/5Regressionen


********************************************************************************
****		DOFILE 6: Regressionsdiagnostik								    ****
********************************************************************************
/* In diesem DoFile wird erledigt:
* Durchführung einer Varietät an Diagnostikbefehlen
*/

do $dofi/6Regressionsdiagnostik


********************************************************************************
****		DOFILE 7: Zusätzliche Analysen								    ****
********************************************************************************
********************************************************************************
*In diesem DoFile wird durchgeführt:
*Bivariat Wohlfahrtsstaatstypen
*Allgemeiner Ort für die Untersuchung weiterer Zusammenhänge

do $dofi/7ZusätzlicheAnalysen


********************************************************************************
****		DOFILE 8: Plots												    ****
********************************************************************************
*In diesem DoFile wird durchgeführt:
*1. Maps
*2. Koefplots


do $dofi/8Plots
