*Masterforschungsprojekt
*WiSe 2021/22
*MP20211211

*Regressionsdiagnostik

capture log close
use $data/ESS5, clear
log using $lofi/LogFileRegressionsdiagnostik, replace
set more off, perm
numlabel _all, add force

********************************************************************************

ssc install midas, replace

*Multikollinearität

*Block 1: Structural respondent characteristics
pwcorr Geschlecht Alter Arbeitslosigkeit Sozialleistung EinkommenPercentileLand BildungsstufeDreiteilung, print(0.05)

*Block 2: Ideational respondent characteristics
pwcorr Religion LinksRechts trustInst trustinHumans satiswithstate, print(0.05)
		//Korrelationen zwischen trust Variablen und satisfaction
		
*Block 3: WS/Monarchien
*theoretisch nicht sinnvoll

*Block 4: Sozioökonomische Makroindikatoren
pwcorr Arbeitslosigkeitsquote GiniIndex BipKopf2 Sozialausgaben2, print(0.05)
		//Zu hohe Korrelation zwischen BipKopf und Sozialausgaben
pwcorr Arbeitslosigkeitsquote GiniIndex BipKopf2 SozialausgabenGeteilt, print(0.05)
		//Lösung

		
*Diagnostik

sort  Land idno
gen id = _n

sort idno
gen idObs = _n

gen expfix1 = exp(fixed1)
gen expfix2 = exp(fixed2)
gen expfix3 = exp(fixed3)
gen expfix4 = exp(fixed4)

hist fixed1, normal ///
title("Normalverteilung Log odds")
graph export "Normalverteilung Log odds.jpg", replace as(png) width(10000)


hist fixed2, normal ///
title("Normalverteilung Log odds")
graph export "Normalverteilung Log odds.jpg", replace as(png) width(10000)


hist fixed3, normal ///
title("Normalverteilung Log odds")
graph export "Normalverteilung Log odds.jpg", replace as(png) width(10000)


hist fixed4, normal ///
title("Normalverteilung Log odds")
graph export "Normalverteilung Log odds.jpg", replace as(png) width(10000)

hist PPear1, normal 
graph export "Hist normal Pearson Residuen.jpg", replace as(png) width(10000)


hist PPear2, normal 
graph export "Hist normal Pearson Residuen.jpg", replace as(png) width(10000)


hist PPear3, normal 
graph export "Hist normal Pearson Residuen.jpg", replace as(png) width(10000)


hist PPear4, normal 
graph export "Hist normal Pearson Residuen.jpg", replace as(png) width(10000)


//Res vs. fit

*AVGleichheit

twoway ///
(scatter PDev1 mu1 if DichAVGleichheit == 0, mcolor(blue%10)) ///
(scatter PDev1 mu1 if DichAVGleichheit == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Gleichheit = 0" 2 "AV Gleichheit = 1")) ///
xtitle("Logits") ///
title("AV Gleichheit: Residuen (Deviance) vs. Wahrscheinlichkeiten")
graph export "AV Gleichheit: Residuen (Deviance) vs. Wahrscheinlichkeiten.jpg", replace as(png) width(10000)
		
twoway ///
(scatter PPear1 mu1 if DichAVGleichheit == 0, mcolor(blue%10)) ///
(scatter PPear1 mu1 if DichAVGleichheit == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Gleichheit = 0" 2 "AV Gleichheit = 1")) ///
xtitle("Logits") ///
title("AV Gleichheit: Residuen (Pearson) vs. Wahrscheinlichkeiten")
graph export "AV Gleichheit: Residuen (Pearson) vs. Wahrscheinlichkeiten.jpg", replace as(png) width(10000)



twoway ///
(scatter PDev1 expfix1 if DichAVGleichheit == 0, mcolor(blue%10)) ///
(scatter PDev1 expfix1 if DichAVGleichheit == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Gleichheit = 0" 2 "AV Gleichheit = 1")) ///
xtitle("Logits") ///
title("AV Gleichheit: Residuen (Deviance) vs. Odds")
graph export "AV Gleichheit: Residuen (Deviance) vs. Odds.jpg", replace as(png) width(10000)
		
twoway ///
(scatter PPear1 expfix1 if DichAVGleichheit == 0, mcolor(blue%10)) ///
(scatter PPear1 expfix1 if DichAVGleichheit == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Gleichheit = 0" 2 "AV Gleichheit = 1")) ///
xtitle("Logits") ///
title("AV Gleichheit: Residuen (Pearson) vs. Odds")
graph export "AV Gleichheit: Residuen (Pearson) vs. Odds.jpg", replace as(png) width(10000)


*AVLeistung

twoway ///
(scatter PDev2 mu2 if DichAVLeistung == 0, mcolor(blue%10)) ///
(scatter PDev2 mu2 if DichAVLeistung == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Leistung = 0" 2 "AV Leistung = 1")) ///
xtitle("Logits") ///
title("AV Leistung: Residuen (Deviance) vs. Wahrscheinlichkeiten")
graph export "AV Leistung: Residuen (Deviance) vs. Wahrscheinlichkeiten.jpg", replace as(png) width(10000)
		
twoway ///
(scatter PPear2 mu2 if DichAVLeistung == 0, mcolor(blue%10)) ///
(scatter PPear2 mu2 if DichAVLeistung == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Leistung = 0" 2 "AV Leistung = 1")) ///
xtitle("Logits") ///
title("AV Leistung: Residuen (Pearson) vs. Wahrscheinlichkeiten")
graph export "AV Leistung: Residuen (Pearson) vs. Wahrscheinlichkeiten.jpg", replace as(png) width(10000)



twoway ///
(scatter PDev2 expfix2 if DichAVLeistung == 0, mcolor(blue%10)) ///
(scatter PDev2 expfix2 if DichAVLeistung == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Leistung = 0" 2 "AV Leistung = 1")) ///
xtitle("Logits") ///
title("AV Leistung: Residuen (Deviance) vs. Odds")
graph export "AV Leistung: Residuen (Deviance) vs. Odds.jpg", replace as(png) width(10000)
		
twoway ///
(scatter PPear2 expfix2 if DichAVLeistung == 0, mcolor(blue%10)) ///
(scatter PPear2 expfix2 if DichAVLeistung == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Leistung = 0" 2 "AV Leistung = 1")) ///
xtitle("Logits") ///
title("AV Leistung: Residuen (Pearson) vs. Odds")
graph export "AV Leistung: Residuen (Pearson) vs. Odds.jpg", replace as(png) width(10000)


*AVBedarf

twoway ///
(scatter PDev3 mu3 if DichAVBedarf == 0, mcolor(blue%10)) ///
(scatter PDev3 mu3 if DichAVBedarf == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Bedarf = 0" 2 "AV Bedarf = 1")) ///
xtitle("Logits") ///
title("AV Bedarf: Residuen (Deviance) vs. Wahrscheinlichkeiten")
graph export "AV Bedarf: Residuen (Deviance) vs. Wahrscheinlichkeiten.jpg", replace as(png) width(10000)
		
twoway ///
(scatter PPear3 mu3 if DichAVBedarf == 0, mcolor(blue%10)) ///
(scatter PPear3 mu3 if DichAVBedarf == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Bedarf = 0" 2 "AV Bedarf = 1")) ///
xtitle("Logits") ///
title("AV Bedarf: Residuen (Pearson) vs. Wahrscheinlichkeiten")
graph export "AV Bedarf: Residuen (Pearson) vs. Wahrscheinlichkeiten.jpg", replace as(png) width(10000)



twoway ///
(scatter PDev3 expfix3 if DichAVBedarf == 0, mcolor(blue%10)) ///
(scatter PDev3 expfix3 if DichAVBedarf == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Bedarf = 0" 2 "AV Bedarf = 1")) ///
xtitle("Logits") ///
title("AV Bedarf: Residuen (Deviance) vs. Odds")
graph export "AV Bedarf: Residuen (Deviance) vs. Odds.jpg", replace as(png) width(10000)
		
twoway ///
(scatter PPear3 expfix3 if DichAVBedarf == 0, mcolor(blue%10)) ///
(scatter PPear3 expfix3 if DichAVBedarf == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Bedarf = 0" 2 "AV Bedarf = 1")) ///
xtitle("Logits") ///
title("AV Bedarf: Residuen (Pearson) vs. Odds")
graph export "AV Bedarf: Residuen (Pearson) vs. Odds.jpg", replace as(png) width(10000)


*AVAnrecht

twoway ///
(scatter PDev4 mu4 if DichAVAnrecht == 0, mcolor(blue%10)) ///
(scatter PDev4 mu4 if DichAVAnrecht == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Anrecht = 0" 2 "AV Anrecht = 1")) ///
xtitle("Logits") ///
title("AV Anrecht: Residuen (Deviance) vs. Wahrscheinlichkeiten")
graph export "AV Anrecht: Residuen (Deviance) vs. Wahrscheinlichkeiten.jpg", replace as(png) width(10000)
		
twoway ///
(scatter PPear4 mu4 if DichAVAnrecht == 0, mcolor(blue%10)) ///
(scatter PPear4 mu4 if DichAVAnrecht == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Anrecht = 0" 2 "AV Anrecht = 1")) ///
xtitle("Logits") ///
title("AV Anrecht: Residuen (Pearson) vs. Wahrscheinlichkeiten")
graph export "AV Anrecht: Residuen (Pearson) vs. Wahrscheinlichkeiten.jpg", replace as(png) width(10000)



twoway ///
(scatter PDev4 expfix4 if DichAVAnrecht == 0, mcolor(blue%10)) ///
(scatter PDev4 expfix4 if DichAVAnrecht == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Anrecht = 0" 2 "AV Anrecht = 1")) ///
xtitle("Logits") ///
title("AV Anrecht: Residuen (Deviance) vs. Odds")
graph export "AV Anrecht: Residuen (Deviance) vs. Odds.jpg", replace as(png) width(10000)
		
twoway ///
(scatter PPear4 expfix4 if DichAVAnrecht == 0, mcolor(blue%10)) ///
(scatter PPear4 expfix4 if DichAVAnrecht == 1, mcolor(red%10)), ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(order(1 "AV Anrecht = 0" 2 "AV Anrecht = 1")) ///
xtitle("Logits") ///
title("AV Anrecht: Residuen (Pearson) vs. Odds")
graph export "AV Anrecht: Residuen (Pearson) vs. Odds.jpg", replace as(png) width(10000)


//Res vs. id

twoway ///
(scatter PPear1 idObs, mcolor(red%10)), ///
ytitle("Pearson residuals", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Pearson Residuen: AV Gleichheit") 
graph export "Pearson Residuen: AV Gleichheit.jpg", replace as(png) width(7000)
		
twoway ///
(scatter PPear1 id if Land == 0, mcolor(khaki%10) ) ///
(scatter PPear1 id if Land == 1, mcolor(blue%10) ) ///
(scatter PPear1 id if Land == 2, mcolor(red%10))  ///
(scatter PPear1 id if Land == 3, mcolor(yellow%10))  ///
(scatter PPear1 id if Land == 4, mcolor(black%10))  ///
(scatter PPear1 id if Land == 5, mcolor(green%10))  ///
(scatter PPear1 id if Land == 6, mcolor(orange%10))  ///
(scatter PPear1 id if Land == 7, mcolor(olive%10))  ///
(scatter PPear1 id if Land == 8, mcolor(dkgreen%10))  ///
(scatter PPear1 id if Land == 9, mcolor(brown%10))  ///
(scatter PPear1 id if Land == 10, mcolor(purple%10))  ///
(scatter PPear1 id if Land == 11, mcolor(olive_teal%10))  ///
(scatter PPear1 id if Land == 12, mcolor(orange_red%10))  ///
(scatter PPear1 id if Land == 13, mcolor(magenta%10))  ///
(scatter PPear1 id if Land == 14, mcolor(teal%10))  ///
(scatter PPear1 id if Land == 15, mcolor(cyan%10))  ///
(scatter PPear1 id if Land == 16, mcolor(maroon%10))  ///
(scatter PPear1 id if Land == 17, mcolor(ltblue%10))  ///
(scatter PPear1 id if Land == 18, mcolor(navy%10))  ///
(scatter PPear1 id if Land == 19, mcolor(sienna%10))  ///
(scatter PPear1 id if Land == 20, mcolor(lime%10))  ///
(scatter PPear1 id if Land == 21, mcolor(lavender%10))  ///
(scatter PPear1 id if Land == 22, mcolor(emerald%10))  ///
(scatter PPear1 id if Land == 23, mcolor(cranberry%10))  ///
(scatter PPear1 id if Land == 24, mcolor(edkblue%10))  ///
(scatter PPear1 id if Land == 25, mcolor(gold%10))  ///
(scatter PPear1 id if Land == 26, mcolor(erose%10)) ///
(scatter PPear1 id if Land == 27, mcolor(pink%10)) ///
(scatter PPear1 id if Land == 28, mcolor(midblue%10)), ///
ytitle("Pearson residuals", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Pearson Residuen nach Land: AV Gleichheit") ///
legend(order(1 "AT" 2 "BE" 3 "BG" 4 "CH" 5 "CY" 6 "CZ" 7 "DE" 8 "DK" 9 "EE" 10 "ES" ///
11 "FI" 12 "FR" 13 "GB" 14 "HR" 15 "HU" 16 "IE" 17 "IS" 18 "IT" 19 "LT" 20 "LV" 21 "ME" ///
22 "NL" 23 "NO" 24 "PL" 25 "PT" 26 "RS" 27 "SE" 28 "SI" 29 "SK" ))
graph export "Pearson Residuen nach Land: AV Gleichheit.jpg", replace as(png) width(7000)

twoway ///
(scatter expfix1 idObs, mcolor(red%10)), ///
ytitle("Odds", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Odds: AV Gleichheit")
graph export "Odds: AV Gleichheit.jpg", replace as(png) width(7000)


twoway ///
(scatter expfix1 id if Land == 0, mcolor(khaki%10) ) ///
(scatter expfix1 id if Land == 1, mcolor(blue%10) ) ///
(scatter expfix1 id if Land == 2, mcolor(red%10))  ///
(scatter expfix1 id if Land == 3, mcolor(yellow%10))  ///
(scatter expfix1 id if Land == 4, mcolor(black%10))  ///
(scatter expfix1 id if Land == 5, mcolor(green%10))  ///
(scatter expfix1 id if Land == 6, mcolor(orange%10))  ///
(scatter expfix1 id if Land == 7, mcolor(olive%10))  ///
(scatter expfix1 id if Land == 8, mcolor(dkgreen%10))  ///
(scatter expfix1 id if Land == 9, mcolor(brown%10))  ///
(scatter expfix1 id if Land == 10, mcolor(purple%10))  ///
(scatter expfix1 id if Land == 11, mcolor(olive_teal%10))  ///
(scatter expfix1 id if Land == 12, mcolor(orange_red%10))  ///
(scatter expfix1 id if Land == 13, mcolor(magenta%10))  ///
(scatter expfix1 id if Land == 14, mcolor(teal%10))  ///
(scatter expfix1 id if Land == 15, mcolor(cyan%10))  ///
(scatter expfix1 id if Land == 16, mcolor(maroon%10))  ///
(scatter expfix1 id if Land == 17, mcolor(ltblue%10))  ///
(scatter expfix1 id if Land == 18, mcolor(navy%10))  ///
(scatter expfix1 id if Land == 19, mcolor(sienna%10))  ///
(scatter expfix1 id if Land == 20, mcolor(lime%10))  ///
(scatter expfix1 id if Land == 21, mcolor(lavender%10))  ///
(scatter expfix1 id if Land == 22, mcolor(emerald%10))  ///
(scatter expfix1 id if Land == 23, mcolor(cranberry%10))  ///
(scatter expfix1 id if Land == 24, mcolor(edkblue%10))  ///
(scatter expfix1 id if Land == 25, mcolor(gold%10))  ///
(scatter expfix1 id if Land == 26, mcolor(erose%10)) ///
(scatter expfix1 id if Land == 27, mcolor(pink%10)) ///
(scatter expfix1 id if Land == 28, mcolor(midblue%10)), ///
ytitle("Odds", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Odds nach Land: AV Gleichheit") ///
legend(order(1 "AT" 2 "BE" 3 "BG" 4 "CH" 5 "CY" 6 "CZ" 7 "DE" 8 "DK" 9 "EE" 10 "ES" ///
11 "FI" 12 "FR" 13 "GB" 14 "HR" 15 "HU" 16 "IE" 17 "IS" 18 "IT" 19 "LT" 20 "LV" 21 "ME" ///
22 "NL" 23 "NO" 24 "PL" 25 "PT" 26 "RS" 27 "SE" 28 "SI" 29 "SK" ))
graph export "Odds nach Land: AV Gleichheit.jpg", replace as(png) width(7000)

twoway ///
(scatter PPear2 idObs, mcolor(red%10) ), ///
ytitle("Pearson residuals", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Pearson Residuen: AV Leistung")
graph export "Pearson Residuen: AV Leistung.jpg", replace as(png) width(7000)


twoway ///
(scatter PPear2 id if Land == 0, mcolor(khaki%10) ) ///
(scatter PPear2 id if Land == 1, mcolor(blue%10) ) ///
(scatter PPear2 id if Land == 2, mcolor(red%10))  ///
(scatter PPear2 id if Land == 3, mcolor(yellow%10))  ///
(scatter PPear2 id if Land == 4, mcolor(black%10))  ///
(scatter PPear2 id if Land == 5, mcolor(green%10))  ///
(scatter PPear2 id if Land == 6, mcolor(orange%10))  ///
(scatter PPear2 id if Land == 7, mcolor(olive%10))  ///
(scatter PPear2 id if Land == 8, mcolor(dkgreen%10))  ///
(scatter PPear2 id if Land == 9, mcolor(brown%10))  ///
(scatter PPear2 id if Land == 10, mcolor(purple%10))  ///
(scatter PPear2 id if Land == 11, mcolor(olive_teal%10))  ///
(scatter PPear2 id if Land == 12, mcolor(orange_red%10))  ///
(scatter PPear2 id if Land == 13, mcolor(magenta%10))  ///
(scatter PPear2 id if Land == 14, mcolor(teal%10))  ///
(scatter PPear2 id if Land == 15, mcolor(cyan%10))  ///
(scatter PPear2 id if Land == 16, mcolor(maroon%10))  ///
(scatter PPear2 id if Land == 17, mcolor(ltblue%10))  ///
(scatter PPear2 id if Land == 18, mcolor(navy%10))  ///
(scatter PPear2 id if Land == 19, mcolor(sienna%10))  ///
(scatter PPear2 id if Land == 20, mcolor(lime%10))  ///
(scatter PPear2 id if Land == 21, mcolor(lavender%10))  ///
(scatter PPear2 id if Land == 22, mcolor(emerald%10))  ///
(scatter PPear2 id if Land == 23, mcolor(cranberry%10))  ///
(scatter PPear2 id if Land == 24, mcolor(edkblue%10))  ///
(scatter PPear2 id if Land == 25, mcolor(gold%10))  ///
(scatter PPear2 id if Land == 26, mcolor(erose%10)) ///
(scatter PPear2 id if Land == 27, mcolor(pink%10)) ///
(scatter PPear2 id if Land == 28, mcolor(midblue%10)), ///
ytitle("Pearson residuals", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Pearson Residuen nach Land: AV Leistung") ///
legend(order(1 "AT" 2 "BE" 3 "BG" 4 "CH" 5 "CY" 6 "CZ" 7 "DE" 8 "DK" 9 "EE" 10 "ES" ///
11 "FI" 12 "FR" 13 "GB" 14 "HR" 15 "HU" 16 "IE" 17 "IS" 18 "IT" 19 "LT" 20 "LV" 21 "ME" ///
22 "NL" 23 "NO" 24 "PL" 25 "PT" 26 "RS" 27 "SE" 28 "SI" 29 "SK" ))
graph export "Pearson Residuen nach Land: AV Leistung.jpg", replace as(png) width(10000)

twoway ///
(scatter expfix2 idObs, mcolor(red%10)), ///
ytitle("Odds", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Odds: AV Leistung")
graph export "Odds: AV Leistung.jpg", replace as(png) width(10000)

twoway ///
(scatter expfix2 id if Land == 0, mcolor(khaki%10) ) ///
(scatter expfix2 id if Land == 1, mcolor(blue%10) ) ///
(scatter expfix2 id if Land == 2, mcolor(red%10))  ///
(scatter expfix2 id if Land == 3, mcolor(yellow%10))  ///
(scatter expfix2 id if Land == 4, mcolor(black%10))  ///
(scatter expfix2 id if Land == 5, mcolor(green%10))  ///
(scatter expfix2 id if Land == 6, mcolor(orange%10))  ///
(scatter expfix2 id if Land == 7, mcolor(olive%10))  ///
(scatter expfix2 id if Land == 8, mcolor(dkgreen%10))  ///
(scatter expfix2 id if Land == 9, mcolor(brown%10))  ///
(scatter expfix2 id if Land == 10, mcolor(purple%10))  ///
(scatter expfix2 id if Land == 11, mcolor(olive_teal%10))  ///
(scatter expfix2 id if Land == 12, mcolor(orange_red%10))  ///
(scatter expfix2 id if Land == 13, mcolor(magenta%10))  ///
(scatter expfix2 id if Land == 14, mcolor(teal%10))  ///
(scatter expfix2 id if Land == 15, mcolor(cyan%10))  ///
(scatter expfix2 id if Land == 16, mcolor(maroon%10))  ///
(scatter expfix2 id if Land == 17, mcolor(ltblue%10))  ///
(scatter expfix2 id if Land == 18, mcolor(navy%10))  ///
(scatter expfix2 id if Land == 19, mcolor(sienna%10))  ///
(scatter expfix2 id if Land == 20, mcolor(lime%10))  ///
(scatter expfix2 id if Land == 21, mcolor(lavender%10))  ///
(scatter expfix2 id if Land == 22, mcolor(emerald%10))  ///
(scatter expfix2 id if Land == 23, mcolor(cranberry%10))  ///
(scatter expfix2 id if Land == 24, mcolor(edkblue%10))  ///
(scatter expfix2 id if Land == 25, mcolor(gold%10))  ///
(scatter expfix2 id if Land == 26, mcolor(erose%10)) ///
(scatter expfix2 id if Land == 27, mcolor(pink%10)) ///
(scatter expfix2 id if Land == 28, mcolor(midblue%10)), ///
ytitle("Odds", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Odds nach Land: AV Leistung") ///
legend(order(1 "AT" 2 "BE" 3 "BG" 4 "CH" 5 "CY" 6 "CZ" 7 "DE" 8 "DK" 9 "EE" 10 "ES" ///
11 "FI" 12 "FR" 13 "GB" 14 "HR" 15 "HU" 16 "IE" 17 "IS" 18 "IT" 19 "LT" 20 "LV" 21 "ME" ///
22 "NL" 23 "NO" 24 "PL" 25 "PT" 26 "RS" 27 "SE" 28 "SI" 29 "SK" ))
graph export "Odds nach Land: AV Leistung.jpg", replace as(png) width(10000)

twoway ///
(scatter PPear3 idObs, mcolor(red%10) ), ///
ytitle("Pearson residuals", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Pearson Residuen: AV Bedarf")
graph export "Pearson Residuen: AV Bedarf.jpg", replace as(png) width(10000)

twoway ///
(scatter PPear3 id if Land == 0, mcolor(khaki%10) ) ///
(scatter PPear3 id if Land == 1, mcolor(blue%10) ) ///
(scatter PPear3 id if Land == 2, mcolor(red%10))  ///
(scatter PPear3 id if Land == 3, mcolor(yellow%10))  ///
(scatter PPear3 id if Land == 4, mcolor(black%10))  ///
(scatter PPear3 id if Land == 5, mcolor(green%10))  ///
(scatter PPear3 id if Land == 6, mcolor(orange%10))  ///
(scatter PPear3 id if Land == 7, mcolor(olive%10))  ///
(scatter PPear3 id if Land == 8, mcolor(dkgreen%10))  ///
(scatter PPear3 id if Land == 9, mcolor(brown%10))  ///
(scatter PPear3 id if Land == 10, mcolor(purple%10))  ///
(scatter PPear3 id if Land == 11, mcolor(olive_teal%10))  ///
(scatter PPear3 id if Land == 12, mcolor(orange_red%10))  ///
(scatter PPear3 id if Land == 13, mcolor(magenta%10))  ///
(scatter PPear3 id if Land == 14, mcolor(teal%10))  ///
(scatter PPear3 id if Land == 15, mcolor(cyan%10))  ///
(scatter PPear3 id if Land == 16, mcolor(maroon%10))  ///
(scatter PPear3 id if Land == 17, mcolor(ltblue%10))  ///
(scatter PPear3 id if Land == 18, mcolor(navy%10))  ///
(scatter PPear3 id if Land == 19, mcolor(sienna%10))  ///
(scatter PPear3 id if Land == 20, mcolor(lime%10))  ///
(scatter PPear3 id if Land == 21, mcolor(lavender%10))  ///
(scatter PPear3 id if Land == 22, mcolor(emerald%10))  ///
(scatter PPear3 id if Land == 23, mcolor(cranberry%10))  ///
(scatter PPear3 id if Land == 24, mcolor(edkblue%10))  ///
(scatter PPear3 id if Land == 25, mcolor(gold%10))  ///
(scatter PPear3 id if Land == 26, mcolor(erose%10)) ///
(scatter PPear3 id if Land == 27, mcolor(pink%10)) ///
(scatter PPear3 id if Land == 28, mcolor(midblue%10)), ///
ytitle("Pearson residuals", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Pearson Residuen nach Land: AV Bedarf") ///
legend(order(1 "AT" 2 "BE" 3 "BG" 4 "CH" 5 "CY" 6 "CZ" 7 "DE" 8 "DK" 9 "EE" 10 "ES" ///
11 "FI" 12 "FR" 13 "GB" 14 "HR" 15 "HU" 16 "IE" 17 "IS" 18 "IT" 19 "LT" 20 "LV" 21 "ME" ///
22 "NL" 23 "NO" 24 "PL" 25 "PT" 26 "RS" 27 "SE" 28 "SI" 29 "SK" ))
graph export "Pearson Residuen nach Land: AV Bedarf.jpg", replace as(png) width(10000)

twoway ///
(scatter expfix3 idObs, mcolor(red%10) ), ///
ytitle("Odds", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Odds: AV Bedarf")
graph export "Odds: AV Bedarf.jpg", replace as(png) width(10000)

twoway ///
(scatter expfix3 id if Land == 0, mcolor(khaki%10) ) ///
(scatter expfix3 id if Land == 1, mcolor(blue%10) ) ///
(scatter expfix3 id if Land == 2, mcolor(red%10))  ///
(scatter expfix3 id if Land == 3, mcolor(yellow%10))  ///
(scatter expfix3 id if Land == 4, mcolor(black%10))  ///
(scatter expfix3 id if Land == 5, mcolor(green%10))  ///
(scatter expfix3 id if Land == 6, mcolor(orange%10))  ///
(scatter expfix3 id if Land == 7, mcolor(olive%10))  ///
(scatter expfix3 id if Land == 8, mcolor(dkgreen%10))  ///
(scatter expfix3 id if Land == 9, mcolor(brown%10))  ///
(scatter expfix3 id if Land == 10, mcolor(purple%10))  ///
(scatter expfix3 id if Land == 11, mcolor(olive_teal%10))  ///
(scatter expfix3 id if Land == 12, mcolor(orange_red%10))  ///
(scatter expfix3 id if Land == 13, mcolor(magenta%10))  ///
(scatter expfix3 id if Land == 14, mcolor(teal%10))  ///
(scatter expfix3 id if Land == 15, mcolor(cyan%10))  ///
(scatter expfix3 id if Land == 16, mcolor(maroon%10))  ///
(scatter expfix3 id if Land == 17, mcolor(ltblue%10))  ///
(scatter expfix3 id if Land == 18, mcolor(navy%10))  ///
(scatter expfix3 id if Land == 19, mcolor(sienna%10))  ///
(scatter expfix3 id if Land == 20, mcolor(lime%10))  ///
(scatter expfix3 id if Land == 21, mcolor(lavender%10))  ///
(scatter expfix3 id if Land == 22, mcolor(emerald%10))  ///
(scatter expfix3 id if Land == 23, mcolor(cranberry%10))  ///
(scatter expfix3 id if Land == 24, mcolor(edkblue%10))  ///
(scatter expfix3 id if Land == 25, mcolor(gold%10))  ///
(scatter expfix3 id if Land == 26, mcolor(erose%10)) ///
(scatter expfix3 id if Land == 27, mcolor(pink%10)) ///
(scatter expfix3 id if Land == 28, mcolor(midblue%10)), ///
ytitle("Odds", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Odds nach Land: AV Bedarf") ///
legend(order(1 "AT" 2 "BE" 3 "BG" 4 "CH" 5 "CY" 6 "CZ" 7 "DE" 8 "DK" 9 "EE" 10 "ES" ///
11 "FI" 12 "FR" 13 "GB" 14 "HR" 15 "HU" 16 "IE" 17 "IS" 18 "IT" 19 "LT" 20 "LV" 21 "ME" ///
22 "NL" 23 "NO" 24 "PL" 25 "PT" 26 "RS" 27 "SE" 28 "SI" 29 "SK" ))
graph export "Odds nach Land: AV Bedarf.jpg", replace as(png) width(10000)


twoway ///
(scatter PPear4 idObs, mcolor(red%10)), ///
ytitle("Pearson residuals", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Pearson Residuen: AV Anrecht") 
graph export "Pearson Residuen: AV Anrecht.jpg", replace as(png) width(10000)


twoway ///
(scatter PPear4 id if Land == 0, mcolor(khaki%10) ) ///
(scatter PPear4 id if Land == 1, mcolor(blue%10) ) ///
(scatter PPear4 id if Land == 2, mcolor(red%10))  ///
(scatter PPear4 id if Land == 3, mcolor(yellow%10))  ///
(scatter PPear4 id if Land == 4, mcolor(black%10))  ///
(scatter PPear4 id if Land == 5, mcolor(green%10))  ///
(scatter PPear4 id if Land == 6, mcolor(orange%10))  ///
(scatter PPear4 id if Land == 7, mcolor(olive%10))  ///
(scatter PPear4 id if Land == 8, mcolor(dkgreen%10))  ///
(scatter PPear4 id if Land == 9, mcolor(brown%10))  ///
(scatter PPear4 id if Land == 10, mcolor(purple%10))  ///
(scatter PPear4 id if Land == 11, mcolor(olive_teal%10))  ///
(scatter PPear4 id if Land == 12, mcolor(orange_red%10))  ///
(scatter PPear4 id if Land == 13, mcolor(magenta%10))  ///
(scatter PPear4 id if Land == 14, mcolor(teal%10))  ///
(scatter PPear4 id if Land == 15, mcolor(cyan%10))  ///
(scatter PPear4 id if Land == 16, mcolor(maroon%10))  ///
(scatter PPear4 id if Land == 17, mcolor(ltblue%10))  ///
(scatter PPear4 id if Land == 18, mcolor(navy%10))  ///
(scatter PPear4 id if Land == 19, mcolor(sienna%10))  ///
(scatter PPear4 id if Land == 20, mcolor(lime%10))  ///
(scatter PPear4 id if Land == 21, mcolor(lavender%10))  ///
(scatter PPear4 id if Land == 22, mcolor(emerald%10))  ///
(scatter PPear4 id if Land == 23, mcolor(cranberry%10))  ///
(scatter PPear4 id if Land == 24, mcolor(edkblue%10))  ///
(scatter PPear4 id if Land == 25, mcolor(gold%10))  ///
(scatter PPear4 id if Land == 26, mcolor(erose%10)) ///
(scatter PPear4 id if Land == 27, mcolor(pink%10)) ///
(scatter PPear4 id if Land == 28, mcolor(midblue%10)), ///
ytitle("Pearson residuals", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Pearson Residuen nach Land: AV Anrecht") ///
legend(order(1 "AT" 2 "BE" 3 "BG" 4 "CH" 5 "CY" 6 "CZ" 7 "DE" 8 "DK" 9 "EE" 10 "ES" ///
11 "FI" 12 "FR" 13 "GB" 14 "HR" 15 "HU" 16 "IE" 17 "IS" 18 "IT" 19 "LT" 20 "LV" 21 "ME" ///
22 "NL" 23 "NO" 24 "PL" 25 "PT" 26 "RS" 27 "SE" 28 "SI" 29 "SK" ))
graph export "Pearson Residuen nach Land: AV Anrecht.jpg", replace as(png) width(10000)


twoway ///
(scatter expfix4 idObs, mcolor(red%10)), ///
ytitle("Odds", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Odds: AV Anrecht")
graph export "Odds: AV Anrecht.jpg", replace as(png) width(10000)


twoway ///
(scatter expfix4 id if Land == 0, mcolor(khaki%10) ) ///
(scatter expfix4 id if Land == 1, mcolor(blue%10) ) ///
(scatter expfix4 id if Land == 2, mcolor(red%10))  ///
(scatter expfix4 id if Land == 3, mcolor(yellow%10))  ///
(scatter expfix4 id if Land == 4, mcolor(black%10))  ///
(scatter expfix4 id if Land == 5, mcolor(green%10))  ///
(scatter expfix4 id if Land == 6, mcolor(orange%10))  ///
(scatter expfix4 id if Land == 7, mcolor(olive%10))  ///
(scatter expfix4 id if Land == 8, mcolor(dkgreen%10))  ///
(scatter expfix4 id if Land == 9, mcolor(brown%10))  ///
(scatter expfix4 id if Land == 10, mcolor(purple%10))  ///
(scatter expfix4 id if Land == 11, mcolor(olive_teal%10))  ///
(scatter expfix4 id if Land == 12, mcolor(orange_red%10))  ///
(scatter expfix4 id if Land == 13, mcolor(magenta%10))  ///
(scatter expfix4 id if Land == 14, mcolor(teal%10))  ///
(scatter expfix4 id if Land == 15, mcolor(cyan%10))  ///
(scatter expfix4 id if Land == 16, mcolor(maroon%10))  ///
(scatter expfix4 id if Land == 17, mcolor(ltblue%10))  ///
(scatter expfix4 id if Land == 18, mcolor(navy%10))  ///
(scatter expfix4 id if Land == 19, mcolor(sienna%10))  ///
(scatter expfix4 id if Land == 20, mcolor(lime%10))  ///
(scatter expfix4 id if Land == 21, mcolor(lavender%10))  ///
(scatter expfix4 id if Land == 22, mcolor(emerald%10))  ///
(scatter expfix4 id if Land == 23, mcolor(cranberry%10))  ///
(scatter expfix4 id if Land == 24, mcolor(edkblue%10))  ///
(scatter expfix4 id if Land == 25, mcolor(gold%10))  ///
(scatter expfix4 id if Land == 26, mcolor(erose%10)) ///
(scatter expfix4 id if Land == 27, mcolor(pink%10)) ///
(scatter expfix4 id if Land == 28, mcolor(midblue%10)), ///
ytitle("Odds", height(10)) ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
title("Odds  nach Land: AV Anrecht") ///
legend(order(1 "AT" 2 "BE" 3 "BG" 4 "CH" 5 "CY" 6 "CZ" 7 "DE" 8 "DK" 9 "EE" 10 "ES" ///
11 "FI" 12 "FR" 13 "GB" 14 "HR" 15 "HU" 16 "IE" 17 "IS" 18 "IT" 19 "LT" 20 "LV" 21 "ME" ///
22 "NL" 23 "NO" 24 "PL" 25 "PT" 26 "RS" 27 "SE" 28 "SI" 29 "SK" ))
graph export "Odds  nach Land: AV Anrecht.jpg", replace as(png) width(10000)



// Totale Residuen


gen totres1 = DichAVGleichheit - fixed1
gen totres2 = DichAVLeistung - fixed2
gen totres3 = DichAVBedarf - fixed3
gen totres4 = DichAVAnrecht - fixed4


hist totres1, norm 
hist totres2, norm
hist totres3, norm
hist totres4, norm



// LV2 Check

//AV1
xtmelogit DichAVGleichheit GeschlechtC AlterJungC AlterMittelAltC AlterAltC ArbeitslosigkeitC SozialleistungC EinkommenPL ///
BildungNiedrigC BildungHochC ReligionC LinksRechtsC trustInstC trustinHumansC satiswithstateC  Arbeitslq GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleFCA == 1, or var	

mltcooksd, fixed keepvar(prefixAV1) counter graph


//AV2
xtmelogit DichAVLeistung GeschlechtC AlterJungC AlterMittelAltC AlterAltC ArbeitslosigkeitC SozialleistungC EinkommenPL ///
BildungNiedrigC BildungHochC ReligionC LinksRechtsC trustInstC trustinHumansC satiswithstateC  Arbeitslq GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleFCA == 1, or var	

mltcooksd, fixed keepvar(prefixAV2) counter graph

//AV3
xtmelogit DichAVBedarf GeschlechtC AlterJungC AlterMittelAltC AlterAltC ArbeitslosigkeitC SozialleistungC EinkommenPL ///
BildungNiedrigC BildungHochC ReligionC LinksRechtsC trustInstC trustinHumansC satiswithstateC  Arbeitslq GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleFCA == 1, or var		

mltcooksd, fixed keepvar(prefixAV3) counter  graph

//AV4
xtmelogit DichAVAnrecht GeschlechtC AlterJungC AlterMittelAltC AlterAltC ArbeitslosigkeitC SozialleistungC EinkommenPL ///
BildungNiedrigC BildungHochC ReligionC LinksRechtsC trustInstC trustinHumansC satiswithstateC  Arbeitslq GiniIndex BipKopf2 Sozialausgaben2 || Land: if SampleFCA == 1, or var		

mltcooksd, fixed keepvar(prefixAV4) counter  graph


save $data/ESS6MLT.dta, replace
save $data/ESS6.dta, replace
