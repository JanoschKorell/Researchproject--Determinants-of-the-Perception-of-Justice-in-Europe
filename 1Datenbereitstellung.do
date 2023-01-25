*Hausarbeit Quanti ME

*Datenbereitstellung

capture log close
use $data/ESS9e03_1, clear
log using $lofi/LogFileDatenbereitstellung, replace
set more off, perm
numlabel _all, add force

********************************************************************************
* In diesem DoFile wird durchgeführt:										   *
* Komprimierung des Ausgangsdatensatzes auf alle verwendeten Variablen         *
* damit der Speicherplatz der verschiedenen Datensätze dennoch möglichst       *
* minimiert wird                                                               *
********************************************************************************
* EINMALIGE DURCHFÜHRUNG!                                                      *
********************************************************************************

//keep idno cntry gndr agea uemp3m hinctnta grspnum netinum infqbst eduyrs eisced iincsrc rlgblg lrscale trstprl trstlgl trstplt trstprt ppltrst pplfair pplhlp stfgov stfdem sofrdst sofrwrk sofrpr sofrprv 
				//Auch im späteren Forschungsprozess verworfene Daten/Variablen 
				//werden behalten

save $data/ESS1HA.dta, replace
