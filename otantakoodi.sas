* Otetaan siemenluku otoksen tekoa varten koneajasta ;
data _NULL_;
 siemen= int(%sysfunc(TIME())) ;
 call symput('siemen',siemen);
run;
%put &siemen;

* Järjestetään perusjoukko ;
proc sort data=perus;
 by henro;
run;
* Tehdään otos, n=2000 ;
proc surveyselect data=perus method=srs
n=2000 seed=&siemen
out=otos;
run;
* Järjestetään otos ;
proc sort data=otos;
 by henro;
run;

* Yhdistetään otos perusjoukkoon, tehdään muuttuja TYYPPI;
data kaikki;
 merge perus(in=a)
    otos(in=b);
 by henro;
 length TYYPPI $ 1.;
 if a then TYYPPI='V';
 if b then TYYPPI='K';

* annetaan arvot muuttujalle REAOH ;
REAOH='PUOTOS';
run;

* Tarkistetaan, että 2000 henkilöllä TYYPPI saa arvon 'K' ;
proc freq;
 tables tyyppi;
run;
