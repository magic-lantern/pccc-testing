#!/usr/bin/awk -f

###############################################################################
# Fieldwidths of the ICD9_ICD10_comparability_public_use_ASCII.dat
#
# Field  Column(s)  widths  Outline
#    1    1 -  18    18     Reserved Positions
#    2   19           1     Record Type
#    3   20           1     Resident Status
#    4   21 -  22     2     State of Occurrence
#    5   23 -  25     3     County of Occurrence
#    6   26           1     Region
#    7   27 -  28     2     Division and State Subcode of Occurrence
#    8   29 -  30     2     Expanded State of Occurrence Code
#    9   31 -  32     2     State of Residence
#   10   33 -  35     3     County of Residence
#   11   36 -  38     3     City of Residence
#   12   39           1     Population Size of City of Residence
#   13   40           1     Metropolitan - Nonmetropolitan County of Residence
#   14   41           1     Region
#   15   42 -  43     2     Division and State Subcode of Residence
#   16   44 -  45     2     Expanded State of Residence Code
#   17   46 -  48     3     NCHS PMSA/MSA of Residence
#   18   49           1     Population Size of County of Occurrence
#   19   50           1     Population Size of County of Residence
#   20   51           1     PMSA/MSA Population Size
#   21   52 -  53     2     Eduction
#   22   54           1     Eduction Recode
#   23   55 -  56     2     Month of Death
#   24   57 -  58     2     Reserved Positions
#   25   59           1     Sex
#   26   60 -  61     2     Detail Race
#   27   62           1     Race Recode 3
#   28   63           1     Race Recode 2
#   29   64 -  66     3     Detail Age
#   30   67 -  68     2     Age Recode 52
#   31   69 -  70     2     Age Recode 27
#   32   71 -  72     2     Age Recode 12
#   33   73 -  74     2     Infant Age Recode 22
#   34   75           1     Place of Death and Decedent's Status
#   35   76           1     Reserved Position
#   36   77           1     Marital Status
#   37   78 -  79     2     State of Birth
#   38   80 -  81     2     Hispanic Origin
#   39   82           1     Hispanic Origin/Race Recode
#   40   83           1     Day of Week of Death
#   41   84           1     Reserved Position
#   42   85 -  87     3     Kind of Business or Industry
#   43   88 -  90     3     Usual Occupation
#   44   91 -  93     3     52 Cause Recode
#   45   94 -  96     3     Reserved Positions
#   46   97 - 101     5     Place (city) of Residence (FIPS)
#   47  102 - 114    13     Reserved Positions
#   48  115 - 118     4     Current Data Year
#   49  119 - 120     2     State of Occurrence (FIPS)
#   50  121 - 123     3     County of Occurrence (FIPS)
#   51  124 - 125     2     State of Residence (FIPS)
#   52  126 - 128     2     County of Residence (FIPS)
#   53  129 - 132     4     PMSA/MSA of Residence (FIPS)
#   54  133           1     Reserved Positions
#   55  134 - 135     2     CMSA of Residence (FIPS)
#   56  136           1     Injury at Work
#   57  137           1     Race Imputation Flag
#   58  138           1     Age Substitution Flag
#   59  139 - 140     2     Reserved Positions
#   60  141           1     Place of Accident for Causes E850-E869 and E880-E928
#   61  142 - 145     4     ICD Code 9th Revision (Underlying Cause of Death)
#   62  146 - 150     5     282 Cause Recode (Underlying Cause of Death)
#   63  151 - 153     3     72 Cause Recode (Underlying Cause of Death)
#   64  154 - 156     3     61 Infant Cause Recode (Underlying Cause of Death)
#   65  157 - 159     3     34 Cause Recode
#   66  160 - 161     2     Number of Entity - Axis Conditions (ICD-9 Multiple Conditions)
#   67  162 - 168     7     ICD-9 Entity - Axis Conditions  1st Condition
#   68  169 - 175     7     ICD-9 Entity - Axis Conditions  2nd Condition
#   69  176 - 182     7     ICD-9 Entity - Axis Conditions  3rd Condition
#   70  183 - 189     7     ICD-9 Entity - Axis Conditions  4th Condition
#   71  190 - 196     7     ICD-9 Entity - Axis Conditions  5th Condition
#   72  197 - 203     7     ICD-9 Entity - Axis Conditions  6th Condition
#   73  204 - 210     7     ICD-9 Entity - Axis Conditions  7th Condition
#   74  211 - 217     7     ICD-9 Entity - Axis Conditions  8th Condition
#   75  218 - 224     7     ICD-9 Entity - Axis Conditions  9th Condition
#   76  225 - 231     7     ICD-9 Entity - Axis Conditions 10th Condition
#   77  232 - 238     7     ICD-9 Entity - Axis Conditions 11th Condition
#   78  239 - 245     7     ICD-9 Entity - Axis Conditions 12th Condition
#   79  246 - 252     7     ICD-9 Entity - Axis Conditions 13th Condition
#   80  253 - 259     7     ICD-9 Entity - Axis Conditions 14th Condition
#   81  260 - 266     7     ICD-9 Entity - Axis Conditions 15th Condition
#   82  267 - 273     7     ICD-9 Entity - Axis Conditions 16th Condition
#   83  274 - 280     7     ICD-9 Entity - Axis Conditions 17th Condition
#   84  281 - 287     7     ICD-9 Entity - Axis Conditions 18th Condition
#   85  288 - 294     7     ICD-9 Entity - Axis Conditions 19th Condition
#   86  295 - 301     7     ICD-9 Entity - Axis Conditions 20th Condition
#   87  302 - 337    36     Reserved Positions
#   88  338 - 339     2     Number of ICD-9 Record-Axis Conditions
#   89  340           1     Reserved Position (TRANSAX flag)
#   90  341 - 345     5     ICD-9 Record - Axis Conditions  1st Conditions
#   91  346 - 350     5     ICD-9 Record - Axis Conditions  2nd Condition
#   92  351 - 355     5     ICD-9 Record - Axis Conditions  3rd Condition
#   93  356 - 360     5     ICD-9 Record - Axis Conditions  4th Condition
#   94  361 - 365     5     ICD-9 Record - Axis Conditions  5th Condition
#   95  366 - 370     5     ICD-9 Record - Axis Conditions  6th Condition
#   96  371 - 375     5     ICD-9 Record - Axis Conditions  7th Condition
#   97  376 - 380     5     ICD-9 Record - Axis Conditions  8th Condition
#   98  381 - 385     5     ICD-9 Record - Axis Conditions  9th Condition
#   99  386 - 390     5     ICD-9 Record - Axis Conditions 10th Condition
#  100  391 - 395     5     ICD-9 Record - Axis Conditions 11th Condition
#  101  396 - 400     5     ICD-9 Record - Axis Conditions 12th Condition
#  102  401 - 405     5     ICD-9 Record - Axis Conditions 13th Condition
#  103  406 - 410     5     ICD-9 Record - Axis Conditions 14th Condition
#  104  411 - 415     5     ICD-9 Record - Axis Conditions 15th Condition
#  105  416 - 420     5     ICD-9 Record - Axis Conditions 16th Condition
#  106  421 - 425     5     ICD-9 Record - Axis Conditions 17th Condition
#  107  426 - 430     5     ICD-9 Record - Axis Conditions 18th Condition
#  108  431 - 435     5     ICD-9 Record - Axis Conditions 19th Condition
#  109  436 - 440     5     ICD-9 Record - Axis Conditions 20th Condition
#  110  441           1     Comparability Analysis Flag
#  111  442 - 443     2     Blank
#  112  444 - 447     4     ICD-10 Underlying Cause Code
#  113  449 - 455     7     ICD-10 Entity - Axis Conditions  1st Condition
#  114  456 - 462     7     ICD-10 Entity - Axis Conditions  2nd Condition
#  115  463 - 469     7     ICD-10 Entity - Axis Conditions  3rd Condition
#  116  470 - 476     7     ICD-10 Entity - Axis Conditions  4th Condition
#  117  477 - 483     7     ICD-10 Entity - Axis Conditions  5th Condition
#  118  484 - 490     7     ICD-10 Entity - Axis Conditions  6th Condition
#  119  491 - 497     7     ICD-10 Entity - Axis Conditions  7th Condition
#  120  498 - 504     7     ICD-10 Entity - Axis Conditions  8th Condition
#  121  505 - 511     7     ICD-10 Entity - Axis Conditions  9th Condition
#  122  512 - 518     7     ICD-10 Entity - Axis Conditions 10th Condition
#  123  519 - 525     7     ICD-10 Entity - Axis Conditions 11th Condition
#  124  526 - 532     7     ICD-10 Entity - Axis Conditions 12th Condition
#  125  533 - 539     7     ICD-10 Entity - Axis Conditions 13th Condition
#  126  540 - 546     7     ICD-10 Entity - Axis Conditions 14th Condition
#  127  547 - 553     7     ICD-10 Entity - Axis Conditions 15th Condition
#  128  554 - 560     7     ICD-10 Entity - Axis Conditions 16th Condition
#  129  561 - 567     7     ICD-10 Entity - Axis Conditions 17th Condition
#  130  568 - 574     7     ICD-10 Entity - Axis Conditions 18th Condition
#  131  575 - 581     7     ICD-10 Entity - Axis Conditions 19th Condition
#  132  582 - 588     7     ICD-10 Entity - Axis Conditions 20th Condition
#  133  589 - 593     5     ICD-10 Record - Axis Conditions  1st Condition
#  134  594 - 598     5     ICD-10 Record - Axis Conditions  2nd Condition
#  135  599 - 603     5     ICD-10 Record - Axis Conditions  3rd Condition
#  136  604 - 608     5     ICD-10 Record - Axis Conditions  4rd Condition
#  137  609 - 613     5     ICD-10 Record - Axis Conditions  5rd Condition
#  138  614 - 618     5     ICD-10 Record - Axis Conditions  6rd Condition
#  139  619 - 623     5     ICD-10 Record - Axis Conditions  7rd Condition
#  140  624 - 628     5     ICD-10 Record - Axis Conditions  8rd Condition
#  141  629 - 633     5     ICD-10 Record - Axis Conditions  9rd Condition
#  142  634 - 638     5     ICD-10 Record - Axis Conditions 10rd Condition
#  143  639 - 643     5     ICD-10 Record - Axis Conditions 11rd Condition
#  144  644 - 648     5     ICD-10 Record - Axis Conditions 12rd Condition
#  145  649 - 653     5     ICD-10 Record - Axis Conditions 13rd Condition
#  146  654 - 658     5     ICD-10 Record - Axis Conditions 14rd Condition
#  147  659 - 663     5     ICD-10 Record - Axis Conditions 15rd Condition
#  148  664 - 668     5     ICD-10 Record - Axis Conditions 16rd Condition
#  149  669 - 673     5     ICD-10 Record - Axis Conditions 17rd Condition
#  150  674 - 678     5     ICD-10 Record - Axis Conditions 18rd Condition
#  151  679 - 683     5     ICD-10 Record - Axis Conditions 19rd Condition
#  152  684 - 688     5     ICD-10 Record - Axis Conditions 20rd Condition
#  153  689           1     Manner of Death



BEGIN {  
  print "Year,Comp_flag,ICD9_00,ICD9_e01,ICD9_e02,ICD9_e03,ICD9_e04,ICD9_e05,ICD9_e06,ICD9_e07,ICD9_e08,ICD9_e09,ICD9_e10,ICD9_e11,ICD9_e12,ICD9_e13,ICD9_e14,ICD9_e15,ICD9_e16,ICD9_e17,ICD9_e18,ICD9_e19,ICD9_e20,ICD9_r01,ICD9_r02,ICD9_r03,ICD9_r04,ICD9_r05,ICD9_r06,ICD9_r07,ICD9_r08,ICD9_r09,ICD9_r10,ICD9_r11,ICD9_r12,ICD9_r13,ICD9_r14,ICD9_r15,ICD9_r16,ICD9_r17,ICD9_r18,ICD9_r19,ICD9_r20,ICD10_00,ICD10_e01,ICD10_e02,ICD10_e03,ICD10_e04,ICD10_e05,ICD10_e06,ICD10_e07,ICD10_e08,ICD10_e09,ICD10_e10,ICD10_e11,ICD10_e12,ICD10_e13,ICD10_e14,ICD10_e15,ICD10_e16,ICD10_e17,ICD10_e18,ICD10_e19,ICD10_e20,ICD10_r01,ICD10_r02,ICD10_r03,ICD10_r04,ICD10_r05,ICD10_r06,ICD10_r07,ICD10_r08,ICD10_r09,ICD10_r10,ICD10_r11,ICD10_r12,ICD10_r13,ICD10_r14,ICD10_r15,ICD10_r16,ICD10_r17,ICD10_r18,ICD10_r19,ICD10_r20"
  FIELDWIDTHS = "689"
}

{

  for (i = 0; i < 20; ++i) {
    icd09entity[i+1] = substr($1, 164 + (i * 7), 4)
    icd09record[i+1] = substr($1, 341 + (i * 5), 4)
    icd10entity[i+1] = substr($1, 451 + (i * 7), 4)
    icd10record[i+1] = substr($1, 589 + (i * 5), 4)
  }

  icd09_underlying_cause = substr($1, 142, 4)
  icd10_underlying_cause = substr($1, 444, 4)
  comparabilityflag = substr($1, 441, 1)
  year = substr($1, 115, 4)

  OFS = ","
  print year,
        comparabilityflag,
        icd09_underlying_cause,
        icd09entity[1], 
        icd09entity[2],
        icd09entity[3],
        icd09entity[4],
        icd09entity[5],
        icd09entity[6],
        icd09entity[7],
        icd09entity[8],
        icd09entity[9],
        icd09entity[10],
        icd09entity[11],
        icd09entity[12],
        icd09entity[13],
        icd09entity[14],
        icd09entity[15],
        icd09entity[16],
        icd09entity[17],
        icd09entity[18],
        icd09entity[19],
        icd09entity[20],
        icd09record[1], 
        icd09record[2],
        icd09record[3],
        icd09record[4],
        icd09record[5],
        icd09record[6],
        icd09record[7],
        icd09record[8],
        icd09record[9],
        icd09record[10],
        icd09record[11],
        icd09record[12],
        icd09record[13],
        icd09record[14],
        icd09record[15],
        icd09record[16],
        icd09record[17],
        icd09record[18],
        icd09record[19],
        icd09record[20], 
        icd10_underlying_cause,
        icd10entity[1], 
        icd10entity[2],
        icd10entity[3],
        icd10entity[4],
        icd10entity[5],
        icd10entity[6],
        icd10entity[7],
        icd10entity[8],
        icd10entity[9],
        icd10entity[10],
        icd10entity[11],
        icd10entity[12],
        icd10entity[13],
        icd10entity[14],
        icd10entity[15],
        icd10entity[16],
        icd10entity[17],
        icd10entity[18],
        icd10entity[19],
        icd10entity[20], 
        icd10record[1], 
        icd10record[2],
        icd10record[3],
        icd10record[4],
        icd10record[5],
        icd10record[6],
        icd10record[7],
        icd10record[8],
        icd10record[9],
        icd10record[10],
        icd10record[11],
        icd10record[12],
        icd10record[13],
        icd10record[14],
        icd10record[15],
        icd10record[16],
        icd10record[17],
        icd10record[18],
        icd10record[19],
        icd10record[20]
}

END {
  exit 0
}

