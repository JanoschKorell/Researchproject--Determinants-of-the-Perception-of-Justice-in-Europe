*Masterforschungsprojekt
*WiSe 2021/22
*MP20211211

*Zusätzliche Analysen

capture log close
use $data/ESS6, clear
log using $lofi/LogFileZusätzlicheAnalysen, replace
set more off, perm
numlabel _all, add force

********************************************************************************
*In diesem DoFile wird durchgeführt:
*Bivariat Wohlfahrtsstaatstypen
*Allgemeiner Ort für die Untersuchung weiterer Zusammenhänge
********************************************************************************


*Bivariat Wohlfahrtsstaatstypen:
*Bivariat: Kreuztabelle
tab Wohlfahrtsstaaten DichAVGleichheit if SampleFCA == 1, row chi

*logit: Referenzgruppe: Osten
logit DichAVGleichheit WSLiberal WSKonserv WSSozialdemo WSMediterran  if SampleFCA == 1

*logit: Referenzgruppe: Liberal
logit DichAVGleichheit WSKonserv WSSozialdemo WSMediterran WSOsten  if SampleFCA == 1

*logit: Referenzgruppe: Konservativ
logit DichAVGleichheit WSLiberal WSSozialdemo WSMediterran WSOsten  if SampleFCA == 1

*xtmelogit: Referenzgruppe: Liberal
xtmelogit DichAVGleichheit WSKonserv WSSozialdemo WSMediterran WSOsten  || Land: if SampleFCA == 1

*xtmelogit: Referenzgruppe: Konservativ
xtmelogit DichAVGleichheit WSLiberal WSSozialdemo WSMediterran WSOsten  || Land: if SampleFCA == 1

*xtmelogit: Referenzgruppe: Sozialdemo
xtmelogit DichAVGleichheit WSKonserv WSLiberal WSMediterran WSOsten  || Land: if SampleFCA == 1

*xtmelogit: Referenzgruppe: Mediterran
xtmelogit DichAVGleichheit WSKonserv WSSozialdemo WSLiberal WSOsten  || Land: if SampleFCA == 1

*xtmelogit: Referenzgruppe: Osten
xtmelogit DichAVGleichheit WSKonserv WSSozialdemo WSMediterran WSLiberal  || Land: if SampleFCA == 1

*xtmelogit: Referenzgruppe: Rest
xtmelogit DichAVGleichheit WSKonserv WSSozialdemo WSMediterran WSOsten WSLiberal || Land: if SampleFCA == 1

*xtmelogit: Referenzgruppe: Rest
xtmelogit DichAVGleichheit WSKonserv WSSozialdemo WSMediterran WSOsten WSLiberal  Monarchien || Land: if SampleFCA == 1


save $data/ESS7.dta, replace
