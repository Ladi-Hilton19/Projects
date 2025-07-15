/********************************************************************************/
/*	Author: OLADIPUPO S. HILTON									Date: 23/5/2022	*/
/*																				*/
/*             										                 		   	*/
/*              Analysis of Guided Learning Hours in Sixth Form   		        */                                                                   
/*			         and further Education Colleges	 					    	*/
/********************************************************************************/


/*************************************/
/*  1: IMPORTING THE DATA INTO SAS  */
/* Procedure step to read the data */
/**********************************/

%LET LIBNAME = '/home/u60859963/IMAT5168/Assessment';   /*DEFINING OUR LIBRARY PATH USING MACROS */
%LET FORMLEARNERS = '/home/u60859963/IMAT5168/Assessment/IMAT5168-FORM.csv'; /*DEFINING FILEPATH USING MACROS */
%LET FELEARNERS = '/home/u60859963/IMAT5168/Assessment/IMAT5168-FE.csv';

Libname lib '&LIBNAME';


/*SAS PREDEFINED MACRO TO OPEN THE FILE TO VIEW AS TABLES*/

%web_drop_table(WORK.IMPORT);

FILENAME GLHFE '&FELEARNERS';

PROC IMPORT DATAFILE=&FELEARNERS
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


%web_open_table(WORK.IMPORT);

%web_drop_table(WORK.IMPORT1);

Filename GLHFORM '&FORMLEARNERS';

PROC IMPORT DATAFILE=&FORMLEARNERS
	DBMS=CSV
	OUT=WORK.IMPORT1;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT1; RUN;

%web_open_table(WORK.IMPORT1);


/*IMPORTING THE DATA SET FOR FORM COLLEGES USING DATA STEP STATEMENTS  */

data GLH_FORM;
   infile &FORMLEARNERS  missover   dsd dlm=',' firstobs=2  obs=max;
          ;

    input
              College : $CHAR19.
              Region  : $CHAR24.
              Total_GLH_Year1 : Best9.
              Learners_Year1  : Best5.
              Total_GLH_Year2 : Best9.
              Learners_Year2  : Best5.
           	  Total_GLH_Year3 : Best9.
           	  Learners_Year3  : Best5.
			;
		  run
  ;
  
  /*IMPORTING THE DATA SET FOR FE COLLEGES USING DATA STEP STATEMENTS  */
data GLH_FE;
   infile  &FELEARNERS missover   dsd dlm=',' firstobs=2  obs=max
          ;

    input
              College : $CHAR19.
              Region  : $CHAR24.
              Total_GLH_Year1 : Best9.
              Learners_Year1  : Best5.
              Total_GLH_Year2 : Best9.
              Learners_Year2  : Best5.
           	  Total_GLH_Year3 : Best9.
           	  Learners_Year3  : Best5.
			;
		  run
  ;
  
  /* CREATING AN INPUT AND OUTPUT FORMAT FOR THE CATEGORICAL VARIABLE SIZE */
 
 Proc Format; 
 Invalue LEVEL
		'Large' = 1
		'Large-medium' = 2
		'Medium' = 3
		'Small-medium' = 4
		'Small' = 5
		' ' = .
		other = 9
;

		Value LEVEL
		1	= 'Large'
		2	= 'Large-medium'
		3	= 'Medium'
		4	= 'Small-medium'
		5	= 'Small'
	    .	= 'missing'
		other = 'ERROR'
;
run ; 
 
 
Data GLH_TOTAL;    
  set glh_fe glh_form;    /* MERGES BOTH DATA SETS TOGETHER */
  Where Region <> ' ' ;   /* REMOVES COLUMNS WITH AGGREGATE VALUES */ 
           	  GLH_per_Learner_Year1 = Total_GLH_Year1/Learners_Year1 ; /*CALCULATED COLUMNS USING EXISTING */
           	  GLH_per_Learner_Year2 = Total_GLH_Year2/Learners_Year2;
           	  GLH_per_Learner_Year3 = Total_GLH_Year3/Learners_Year3;
           	  Total_GLH = Total_GLH_Year1+Total_GLH_Year2+Total_GLH_Year3;
           	  Total_Learners = Learners_Year1 + Learners_Year2 + Learners_Year3;
           	  GLH_per_Learner =  Total_GLH/Total_Learners;
           	  If Total_GLH > 3000000 then Size = 1;
           	  else If Total_GLH >= 2000000 and Total_GLH < 3000000 then Size = 2;
           	  else If Total_GLH >= 1000000 and Total_GLH < 2000000 then Size = 3;
           	  else If Total_GLH >= 500000 and Total_GLH < 1000000 then Size = 4;
           	  else If Total_GLH < 500000 then Size = 5;
           	  else Total_GLH = . ;
           	  If Total_GLH_Year1 > 3000000 then Size_Year1 = 1;
           	  else If Total_GLH_Year1 >= 2000000 and Total_GLH_Year1 < 3000000 then Size_Year1 = 2;
           	  else If Total_GLH_Year1 >= 1000000 and Total_GLH_Year1 < 2000000 then Size_Year1 = 3;
           	  else If Total_GLH_Year1 >= 500000 and Total_GLH_Year1 < 1000000 then Size_Year1 = 4;
           	  else If Total_GLH_Year1 < 500000 then Size_Year1 = 5;
           	  else Total_GLH_Year1 = . ;
           	  If Total_GLH_Year2 > 3000000 then Size_Year2 = 1;
           	  else If Total_GLH_Year2 >= 2000000 and Total_GLH_Year2 < 3000000 then Size_Year2 = 2;
           	  else If Total_GLH_Year2 >= 1000000 and Total_GLH_Year2 < 2000000 then Size_Year2 = 3;
           	  else If Total_GLH_Year2 >= 500000 and Total_GLH_Year2 < 1000000 then Size_Year2 = 4;
           	  else If Total_GLH_Year2 < 500000 then Size_Year2 = 5;
           	  else Total_GLH_Year2 = . ;
           	  If Total_GLH_Year3 > 3000000 then Size_Year3 = 1;
           	  else If Total_GLH_Year3 >= 2000000 and Total_GLH_Year3 < 3000000 then Size_Year3 = 2;
           	  else If Total_GLH_Year3 >= 1000000 and Total_GLH_Year3 < 2000000 then Size_Year3 = 3;
           	  else If Total_GLH_Year3 >= 500000 and Total_GLH_Year3 < 1000000 then Size_Year3 = 4;
           	  else If Total_GLH_Year3 < 500000 then Size_Year3 = 5;
           	  else Total_GLH_Year3 = . ;
           	  If GLH_per_Learner = . then delete; /* REMOVING ROWS WITH MISSING VALUES */
LENGTH
	 	 College $19
         Region   $24
         Total_GLH_Year1 8
         Learners_Year1 8
		 GLH_per_Learner_Year1 8
         Total_GLH_Year2 8
         Learners_Year2 8
 		 GLH_per_Learner_Year2 8
         Total_GLH_Year3 8
         Learners_Year3 8 
         GLH_per_Learner_Year3 8
         Total_GLH 8
         Total_Learners 8
         GLH_per_Learner 8
         Size 8
         Size_Year1 8
         Size_Year2 8
         Size_Year3 8
         ;
         Format
         College $CHAR34.
         Region $CHAR24.
         Total_GLH_Year1  Best9.
         Learners_Year1   Best6.
		 GLH_per_Learner_Year1 Best5.
         Total_GLH_Year2  Best9.
         Learners_Year2  Best6.
		 GLH_per_Learner_Year2 Best5.
         Total_GLH_Year3 Best9.
         Learners_Year3  Best6.
         GLH_per_Learner_Year3 Best5.
         Total_GLH Best9.
         Total_Learners Best6.
         GLH_per_Learner Best5.
         Size LEVEL.
		 Size_Year1 LEVEL.
         Size_Year2 LEVEL.
         Size_Year3 LEVEL.
        
         ;
	Label
              College = 'College Type'
              Region  = 'English Region' 
              Total_GLH_Year1 = 'Total Guided Learning Hours for Year 1' 
              Learners_Year1 = 'Number of students in Year 1'
			  GLH_per_Learner_Year1 = 'Guided Learning hours per Learner for Year 1'
              Total_GLH_Year2 = 'Total Guided Learning Hours for Year 2'
              Learners_Year2 = 'Number of Students in Year 2'
			  GLH_per_Learner_Year2 = 'Guided Learning hours per Learner for Year 2'
           	  Total_GLH_Year3 = 'Total Guided Learning Hours for Year 3'
           	  Learners_Year3 = 'Number of Students in Year 3'
           	  GLH_per_Learner_Year3 = 'Guided Learning hours per Learner for Year 3' 
         	  Total_GLH = 'Total Guided Learning Hours for the three Years' 
         	  Total_Learners = 'Number of Students in all Years'
         	  GLH_per_Learner = 'Guided Learning hour per Learner over the 3 years'
              Size = 'Size of College based on Total Guided Learning Hours' 
              Size_Year1 = 'Size of College based on Total Guided Learning Hours in Year1'
    	      Size_Year2 = 'Size of College based on Total Guided Learning Hours in Year2'
	          Size_Year3 = 'Size of College based on Total Guided Learning Hours in Year3'
           	  ;
           	  
           	  format Size LEVEL. ;
		  run
  ;  
  
 /* Check contents of created data */

ods exclude enginehost ;
proc contents data= glH_total varnum ;
run; 
ods exclude none ;
 
  /************************************************************/ 
 /*GETTING FREQUENCY DISTRIBUTION OF CLASS VARIABLES IN DATA */
/************************************************************/

 proc freq data= GLH_TOTAL  ;
    tables SIZE SIZE_Year1 SIZE_Year2 SIZE_Year3 COLLEGE REGION / missing out= PKF ;
run;

  /************************************************************/ 
 /*    CHECKING FOR EXTREME VALUES IN THE DATA               */
/************************************************************/

 
 /* Create ID column for Data to provide key */
data idglh;
set glh_total ;
format ID 6.;
ID + 1;
output;
run; 
 
/* create out a table of extreme values */

ods output ExtremeObs= EXTREME_GLH ;
proc univariate data= idglh nextrobs= 10;
    var 
       GLH_per_Learner_Year1
       GLH_per_Learner_Year2  
       GLH_per_Learner_Year3 
       GLH_per_Learner;
    id ID;
run;
ods select all;

/*Show places in the data with extreme values using created table */

Proc sql;
    title 'College with lowest amount of GLH per Learner' ;
    select *
    from IDGLH
    where ID in (
        select ID_lOW
        from EXTREME_GLH
        )    
    order by glh_per_learner desc ;
    title 'College with highest numbers of GLH per Learner' ;
    select *
    from IDGLH
    where ID in (
        select ID_high
        from EXTREME_GLH
        )    
    order by glh_per_learner desc ;
    title ;
quit;

/* From the table it is observed that the lowest glhperlearner values fall within FE college types,
  while the highest fall within the Sixth form colleges. Since We do not have and equal frequency
  distribution of data among college types, the outliers are kept*/



  /***************************************************************/ 
 /* Checking for the normality of the data's dependent variables */
/***************************************************************/ 

proc univariate data= glh_total noprint ;
    var 
   GLH_per_Learner_Year1
       GLH_per_Learner_Year2  
       GLH_per_Learner_Year3 
       GLH_per_Learner
        ;
    histogram  / kernel normal(mu= est sigma= est) ;
    qqplot / normal(mu= est sigma= est) ;
    inset n nmiss min q1 median q3 max skew kurt / position= SE ;
run;
ods select all ;


/* The output,  shows the p values for the goodness of fit test is less than 
	0.05, also the data distribution has quite high positive skewness(>1) and the histogram
	plot shows the data is not normally distributed therefore we will need to transform each variable*/


/****************************************/
/* 	   Transforming Data               */
/*     to a normal model              */
/*************************************/

    
/*   Writing Box transformations Funcitons  */
/*******************************************/

options cmplib=(glhtransform);
proc fcmp outlib=work.glhtransform1.lib;
    function p3(x);  /*cube */
		return (x*x*x);
	endsub;

	function p2(x);  /*square*/
		return (x*x);
	endsub;

    function sqrttran(x);  /*sqroot*/
  		return ((x)** 0.5);
  	endsub;

    function logtran(x);   /*natural log */
		return (log(1+x));
	endsub;

	function rcpsqrtran(x);   /*recipical square root */
		return ((1+x)**-0.5);
	endsub;

run;

/* Transforming the data using reciprocal squareroot after trying different transformations*/

options cmplib=(glhtransform);

data tranglh;
set glh_total; 
trnglh1rcpsqrt = rcpsqrtran(glh_per_learner_year1);
trnglh2rcpsqrt = rcpsqrtran(glh_per_learner_year2);
trnglh3rcpsqrt = rcpsqrtran(glh_per_learner_year3);
trnglhrcpsqrt= rcpsqrtran(glh_per_learner);
run;

proc univariate data= tranglh normal ;
    var 
	 trnglh1rcpsqrt 
	 GLh_per_learner_year1
	trnglh2rcpsqrt
	glh_per_learner_year2
	trnglh3rcpsqrt
	glh_per_learner_year3
	trnglhrcpsqrt
	glh_per_learner;
       ;
	histogram  / KERNEL normal(mu= est sigma= est) ;
    qqplot / normal(mu= est sigma= est) ;
    inset n nmiss min q1 median q3 max skew kurt / position= SE ;
run;
   
 /* The output after transformations shows the data distribution now has a low skewness for              */
/* all the variables and the histogram qq plot shows the data is now closer to a normally distribution  */


/****************************************/
/* 	   Macros for Analysis of Data    */
/**************************************/

options symbolgen mprint mlogic;
%macro summary_statistics(data= /* data set name */
    , class= /* classifyer variable */
    , var= /* calculated variable */
    );
proc means 
	data = &data n min mean std max;
	class  &class;
	var  &var;
run;

%mend summary_statistics;

*options nosymbolgen nomprint nomlogic;

*options symbolgen mprint mlogic;
%macro  univariate(data= /* data set name */
    , class= /* classifyer variable */
    , var= /* calculated variable */
    );
proc univariate 
	data = &data;
	class &class;
	var &var;
	qqplot /normal(mu=est sigma=est);
	histogram /normal;
run;


%mend univariate;

*options nosymbolgen nomprint nomlogic;

*options symbolgen mprint mlogic;
%macro  ttest(data= /* data set name */
    , class= /* classifyer variable */
    , var= /* calculated variable */
    );

ods graphics on;
proc ttest
	data = &data;
	class &class; 
	var &var; 
run;

%mend ttest;

*options nosymbolgen nomprint nomlogic;


*options symbolgen mprint mlogic;
%macro  anova(data= /* data set name */
    , class= /* classifyer variable */
    , var= /* calculated variable */
    );

proc anova
	data = &data;
	class &class;
	model &var = &class;
	means &class /lsd; 
run; 


%mend anova;

*options nosymbolgen nomprint nomlogic;

*options symbolgen mprint mlogic;
%macro  glm(data= /* data set name */
    , class= /* classifyer variable */
    , var= /* calculated variable */
    );
proc GLM     
    data = &data;
    class &class;
	model &var = &class;
    means &class /lsd hovtest=bartlett ;
    output out= RESIDUALS r= residual p= predicted;
quit;

proc univariate data= RESIDUALS normal ;
    var residual ;
    histogram / normal(mu= est sigma= est) kernel(color=red) ;
    ppplot / normal(mu= est sigma= est) ;
    qqplot / normal(mu= est sigma= est) ;
    inset n nmiss min q1 median q3 max skew kurt / position= SE ;
run;

proc sgplot 
	data= RESIDUALS;
	scatter x=predicted y=residual;
 	refline 0 / axis=y;
run;

%mend glm;

%macro  TwoWay_Anova(data= /* data set name */
    , class1= /* classifyer variable */
    , class2=
    , model= /* calculated variable */
    );
    
   
proc glm 
	data= &data;
 	class &class1 &class2;
 	model &model=&class1 &class2 &class1*&class2; /* includes interaction */
 	lsmeans &class1 &class2 &class1*&class2;
 	output out=interact p=predicted r=residual;
run;


proc glm 
	data= &data ;
 	class &class1 &class2;
 	model &model=&class1 &class2 ; /* without interaction */
 	means &class1 ;
 	means &class2;
 	output out=nointeract p=predicted r=residual;
run; 

%mend TwoWay_Anova;

options nosymbolgen nomprint nomlogic;


/****************************************/
/* 	  Analysis of Data                 */
/**************************************/

/*EFFECT OF YEAR ON GLH PER LEARNER*/

title 'Effect of Year on GLH_per_Learner' ;
%summary_statistics(data= tranglh,
 class= , 
 var= glh_per_learner_year1 glh_per_learner_year2 glh_per_learner_year3)
		;
 
 /* there is no significant difference in guided learning hours for the three years, 
   the mean of each year are not far apart from one another. Year1  however is a
   little different from other years based on the mean and standard deviation 
     of its observations from the mean  */
    
   /*EFFECT OF REGION ON GLH PER LEARNER*/
 
title 'Effect of Region on GLH_per_Learner' ;
%summary_statistics(data= tranglh,  /* SUMMARY STATISTICS USING REGION & TOTAL GLHPERLEARNER in ALL YEARS*/
					class=region, 
					var=glh_per_learner);	
title 'Test for normalty of Region on GLH_per_Learner' ;		
%univariate(data=tranglh, class=region, var= trnglhrcpsqrt);

/* kurtosis and Skewness have values less than one in majority of the regions showing
 it fits a normal distribution though the p-values are less than 0.05 for majority. */


/*Anova Analysis of effect of region on total guided learning hours per learner in all years*/
 title 'Anova analysis of Effect of Region on GLH_per_Learner' ;
%anova(data=tranglh, class=region, var= trnglhrcpsqrt);

/* From Anova analysis there is a major difference in total guided learning hours in the college regions,
 p-value and sum of squares is less than 0.05.Also there is a large variation across the mean
 values across some regions, with some regions having a large difference in GLHperLearner
 from others(Greater London & North West)         */


/* Summary statistics for Effect of Size on GLH_per_Learners in all years*/

 title 'Effect of Size on GLH_per_Learner' ;   
%summary_statistics(data= tranglh, 
					class=size, 
					var=glh_per_learner);	
title 'Test for normalty of Size on GLH_per_Learner';				
%univariate(data=tranglh, class=size, var= trnglhrcpsqrt);					

/*Anova Analysis of effect of size on total guided learning hours per learner */
 title 'Anova analysis of Effect of Size on GLH_per_Learner' ;
%anova(data=tranglh, class=size, var= trnglhrcpsqrt);   /* using transformed variable to fit assumption */


/* Based on Size there is no significant difference in the sizes of colleges based on GLH per learner.
Majority of the colleges fall within the Large and Large-Medium category which have close mean values.  
The p-value for the anova analysis is 0.22 and the sum of squares is 0.0018. There is also no significant
relationship among individual size levels.  */



  /* Summary statistics for Effect of College TYPE on GLH_per_Learner  */
title 'Effect of College TYPE on GLH_per_Learner' ;
%summary_statistics(data= tranglh,
 class= College, 
 var= glh_per_learner );
 
/* there is a major difference in guided learning hours in the two college types, 
   there is a major difference in the means of their guided learning hours.       */
  
 title 'T-test showing effect of College type on glhperLearner in all 3 years';
%ttest(data= tranglh, class= College, var= trnglhrcpsqrt);

/* the P-value(<0.01) shows there is major difference in the two college types, 
   there is a major difference in the means of their guided learning hours. The t-value(22.43) 
   also shows a large difference in the learning hour per learner for each college */



/* USING glH per learner for each year by College type */

title'Ttest showing effect of Year1 on learning hours per learner by College type ';
%ttest(data= tranglh, class= College, var=  trnglh1rcpsqrt );
title'Ttest showing effect of Year 2 on learning hours per learner by College type ';
%ttest(data= tranglh, class= College, var=  trnglh2rcpsqrt );
title'Ttest showing effect of Year 3 on learning hours per learner by College type ';
%ttest(data= tranglh, class= College, var=  trnglh3rcpsqrt );

/* the P-value(<0.01) for all years shows there is major difference in the two college types, 
   there is a major difference in the means of their guided learning hours. The t-value for each
   also shows a large difference in the learning hour per learner for each college. There is no 
   major difference in the different years comparing the standard deviations across the 3 years */


title 'Effect of Year1 on GLH_per_Learner by Size' ;
%summary_statistics(data= tranglh,
 class= size_year1, 
 var= glh_per_learner_year1);

title 'Effect of Year2 on GLH_per_Learner by Size' ;
%summary_statistics(data= tranglh,
 class= size_year2, 
 var= glh_per_learner_year2 );
 
title 'Effect of Year2 on GLH_per_Learner by Size' ;
%summary_statistics(data= tranglh,
 class= size_year3, 
 var= glh_per_learner_year3 );
 
 /* Looking at the means across the years there is a consistent gap between the mean values of GLHperLearner
 for each size category, the medium and smaller sizes having more significant hours than the larger ones */
 
/* glm Analysis of effect of year on learning hours per Learner by size*/ 
title'GLM analysis showing effect of Year1 on learning hours per learner by Size' ;
%glm(data=tranglh, class=size_year1, var= trnglh1rcpsqrt);
title'GLM analysis showing effect of Year2 on learning hours per learner by Size' ;
%glm(data=tranglh, class=size_year2, var= trnglh2rcpsqrt);
title'GLM analysis showing effect of Year3 on learning hours per learner by Size' ;
%glm(data=tranglh, class=size_year3, var= trnglh3rcpsqrt);

/* For each of the years the p-value for all tests including shapiro-wilk test and the sum of squares(Type III SS)
 is less than 0.05 which indicates there is a significant difference between sizes. the test for normality 
 of the residuals also showed the p-values were less than 0.05 and the skewness and kuotorsis of  also showed
the ditribution was close to a normal distribution as they were less than 1. The major levels with large 
differences include Large Medium and Small Medium, Large Medium and Medium(all years) and Medium and Large in Year 2
Medium and Small Medium in Year 3 */



/* Effect of Region and Year on GLHperhour by Size */


title 'Effect of Region and Year 1 on GLHperLearner by Size';
%TwoWay_Anova(data= tranglh, class1 = Region, class2 = Size_year1, model =trnglh1rcpsqrt );
title 'Effect of Region and Year 2 on GLHperLearner by Size';
%TwoWay_Anova(data= tranglh, class1 = Region, class2 = Size_year2, model =trnglh2rcpsqrt);
title 'Effect of Region and Year 3 on GLHperLearner by Size';
%TwoWay_Anova(data= tranglh, class1 = Region, class2 = Size_year3, model =trnglh3rcpsqrt );


/* With interaction the model is not significantly different across the years with a P-value greater than 
0.05(0.5795). Without interaction there is a significant differnce in the glh per learner
for different sizes of colleges across the years with p-values less than 0.05. Size and Region both individually
have a significant effect on the GLH per learner. East midlands, West midlands, Yorkshire and South West
have similarities between their large and large-medium schools  */


/* Effect of Region and Year on GLHperhour by College type */

title 'Effect of Year and Region on GLH_per_Learner by College Type' ;
%summary_statistics(data= tranglh,
 class= region college , 
 var= glh_per_learner_year1 glh_per_learner_year2 glh_per_learner_year3);


title 'Effect of Region and Year on GLHperLearner by College type';
%TwoWay_Anova(data= tranglh, class1 = Region, class2 = college, model =trnglh1rcpsqrt trnglh2rcpsqrt trnglh3rcpsqrt);

/* There is interaction betwwen the region and the college type in Year1 and in year2 with p-values less
than 0.05 showing that there is an effect of college type, region and year on the GLH per learner. 
The Ls means in year 1, 2, and 3 also shows there is a major difference in all college types in all regions
 */
