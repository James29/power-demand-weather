# power-demand-weather
Estimating the impact of random weather shocks on power demand in the US.

See workfolow_readme.txt for the order and explanation of various R scripts. 

Important Notes:
1 - The code is set to run on the Kaholo workstation (32 cores and ~260GB RAM). The code will need to be substantially restructured to run successfully on a workstation with less memory but I have not checked the actual peak memory requirements of each step. Several steps of the data compilation and empirical work make use of parallel processing and in some cases use up to 32 cores, these will need to be adjusted to work on a machine with fewer cores or could be increased if you have more than 32.

2 - This repository makes extensive use of the R data.table package for preformance reasons (and my personal preference). The code has some documentation of the general motivation and overview of the process of each section but I have not documented data.table functionality that may not be familiar to users who use base data.frame, dplyr, or other data structures in R. See https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html
