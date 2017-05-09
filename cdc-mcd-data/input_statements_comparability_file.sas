/*
This SAS code generates a temporary SAS data file based on all the variables and records
from the United States public use ICD9, ICD10 comparability file.  Variable descriptions
are found on the file documentation provided within this CD-ROM package.
*/

data work.comparability;
	infile 'C:\ICD9_ICD10_comparability_public_use_ASCII.dat' lrecl=720;
	input @19 rectype $1.
	      @20 resstat $1. 
		@21 stocc $2. 
		@23 cntyocc $3. 
		@26 regocc $1. 
		@27 divocc $1. 
		@28 stsubocc $1.
	    @29 exstocc $2. 
		@31 stres $2. 
		@33 cntyres $3. 
		@36 cityres $3. 
		@39 pcityres $1. 
		@40 metro $1. 
	    @41 regres $1. 
		@42 divres $1. 
		@43 stsubres $1. 
		@44 exstres $2. 
		@46 msares $3. 
		@49 pcntyocc $1. 
	    @50 pcntyres $1. 
		@51 msasize $1. 
		@52 educ $2. 
		@54 edrecode $1. 
		@55 month $2. 
	    @59 sex $1. 
		@60 detrace $2. 
		@62 racer3 $1. 
		@63 racer2 $1. 
		@64 detage $3. 
		@67 ager52 $2. 
		@69 ager27 $2. 
	    @71 ager12 $2. 
		@73 iager22 $2. 
		@75 place $1.
		@77 marital $1. 
		@78 stbirth $2. 
		@80 hisporg $2. 
		@82 hisprrec $1. 
		@83 dayofwk $1.
		@85 busind $3. 
		@88 occup $3. 
		@91 cause52 $3. 
		@97 plrsfips $5. 
		@115 year $4. 
		@119 stocfips $2. 
		@121 cnocfips $3. 
		@124 strsfips $2. 
		@126 cnrsfips $3. 
		@129 msarfips $4.  
		@134 cmsafips $2. 
		@136 injwork $1. 
		@137 raceimp $1. 
		@138 agesub $1. 
/* ICD-9 Underlying Cause Data */
		@141 plofacc $1.
		@142 cause $4. 
		@146 cause282 $5. 
		@151 cause72 $3. 
		@154 icause61 $3. 
		@157 cause34 $3. 
/* ICD-9 Multiple Cause Data */
		@160 nenaxcon $2. 
		@162  ENTAX1 $7. @169  ENTAX2 $7. @176  ENTAX3 $7. @183  ENTAX4 $7. 
		@190  ENTAX5 $7. @197  ENTAX6 $7. @204  ENTAX7 $7. @211  ENTAX8 $7. 
		@218  ENTAX9 $7. @225  ENTAX10 $7. @232  ENTAX11 $7. @239  ENTAX12 $7. 
		@246  ENTAX13 $7. @253  ENTAX14 $7. @260  ENTAX15 $7. @267  ENTAX16 $7. 
		@274  ENTAX17 $7. @281  ENTAX18 $7. @288  ENTAX19 $7. @295  ENTAX20 $7. 
		@338 nrcaxcon $2.
		@341  RECAX1 $5. @346  RECAX2 $5. @351  RECAX3 $5. @356  RECAX4 $5. 
		@361  RECAX5 $5. @366  RECAX6 $5. @371  RECAX7 $5. @376  RECAX8 $5. 
		@381  RECAX9 $5. @386  RECAX10 $5. @391  RECAX11 $5. @396  RECAX12 $5. 
		@401  RECAX13 $5. @406  RECAX14 $5.	@411  RECAX15 $5. @416  RECAX16 $5. 
		@421  RECAX17 $5. @426  RECAX18 $5. @431  RECAX19 $5. @436  RECAX20 $5.
/* ICD10 variables */
		@441 compflag $1.
		@444 uc10 $4. 
		@449  EAX10_1 $7. @456  EAX10_2 $7. @463  EAX10_3 $7. @470  EAX10_4 $7. @477  EAX10_5 $7. 
		@484  EAX10_6 $7. @491  EAX10_7 $7.	@498  EAX10_8 $7. @505  EAX10_9 $7. @512  EAX10_10 $7. 
		@519  EAX10_11 $7. @526  EAX10_12 $7. @533  EAX10_13 $7. @540  EAX10_14 $7.	@547  EAX10_15 $7. 
		@554  EAX10_16 $7. @561  EAX10_17 $7. @568  EAX10_18 $7. @575  EAX10_19 $7. @582  EAX10_20 $7.

		@589  RAX10_1 $5. @594  RAX10_2 $5. @599  RAX10_3 $5. @604  RAX10_4 $5. @609  RAX10_5 $5. 
		@614  RAX10_6 $5. @619  RAX10_7 $5.	@624  RAX10_8 $5. @629  RAX10_9 $5. @634  RAX10_10 $5. 
		@639  RAX10_11 $5. @644  RAX10_12 $5. @649  RAX10_13 $5. @654  RAX10_14 $5.	@659  RAX10_15 $5. 
		@664  RAX10_16 $5. @669  RAX10_17 $5. @674  RAX10_18 $5. @679  RAX10_19 $5. @684  RAX10_20 $5.
		@689 mandth10 $1.;
run;

proc contents data=work.comparability;
run;

		
		
		
