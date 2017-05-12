cd %~dp0

del *.rds

START "NED Summary Part  1 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 1 1443053
START "NED Summary Part  2 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 1443054 2886106
START "NED Summary Part  3 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 2886107 4329159
START "NED Summary Part  4 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 4329160 5772212
START "NED Summary Part  5 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 5772213 7215265
START "NED Summary Part  6 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 7215266 8658318
START "NED Summary Part  7 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 8658319 10101371
START "NED Summary Part  8 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 10101372 11544424
START "NED Summary Part  9 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 11544425 12987477
START "NED Summary Part 10 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 12987478 14430530
START "NED Summary Part 11 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 14430531 15873583
START "NED Summary Part 12 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 15873584 17316636
START "NED Summary Part 13 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 17316637 18759689
START "NED Summary Part 14 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 18759690 20202742
START "NED Summary Part 15 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 20202743 21645795
START "NED Summary Part 16 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 21645796 23088848
START "NED Summary Part 17 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 23088849 24531901
START "NED Summary Part 18 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 24531902 25974954
START "NED Summary Part 19 of 20" "C:\Program Files\R\R-3.3.3\bin\Rscript.exe"       --vanilla pccc-testing.R 25974955 27418007
START "NED Summary Part 20 of 20" /WAIT "C:\Program Files\R\R-3.3.3\bin\Rscript.exe" --vanilla pccc-testing.R 27418008 28861060


"C:\Program Files\R\R-3.3.3\bin\R.exe" CMD BATCH --vanilla neds-summary.R
pause
