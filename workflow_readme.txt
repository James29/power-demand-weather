1. Download data (1_Download.R)
  1A: Download NARR
  1B: Download EIA 930
  1C: Download BA shapefile
  1D: Download population grid
  1E: Download EIA Meta
  
2. Clean Data
  2A: Reproject BA shapefile to LCC to match NARR (2_reprojSF.R)
  2B: Match EIA ids to BASF ids (2_matchIDs.R)
  2C: Consolidate BAs in each interconnection (2_mergeBAs.R)
  
3. Calculate Weather
  3A: Calculate pop weighted weather for each consolidated BA (3_calcBAWDD.R)
  3B: Aggregate EIA930 Data to consolidated BAs (3_clean930.R)
  3C: merge weather and demand data to prep for regression (3_mergeforreg.R)


4. Regression
  4A: (optional) Exploratory plotting (4_plotdata.R)
  4B: Base regression and plots (4_basereg.R)
  4C: Cross-validation (4_cv.R)
