-- Assessing Environmental Justice Concern in the Twin Cities Metro Area

-- Summary Statistics --
------------------------------------
-- Total Population (poptot_mc) of Census Tracts with and without Environmental Justice Concerns (tr_ej) 
SELECT 
  tr_ej, 
  AVG(poptot_mc) AS avg_population, 
  COUNT(*) AS count, 
  MIN(poptot_mc) AS min_population, 
  MAX(poptot_mc) AS max_population, 
  ROUND(STDDEV_POP(poptot_mc), 2) AS std_dev_population 
FROM 
  equity_considerations
GROUP BY 
  tr_ej;
------------------------------------
-- Average Median Household Income (mdhhincnow) Census Tracts with and without Environmental Justice Concerns (tr_ej) 
SELECT 
  tr_ej, 
  AVG(mdhhincnow) AS avg_mdhhincnow, 
  COUNT(*) AS count, 
  MIN(mdhhincnow) AS min_mdhhincnow, 
  MAX(mdhhincnow) AS max_mdhhincnow, 
  ROUND(CAST(STDDEV_POP(mdhhincnow) AS numeric), 2) AS std_dev_mdhhincnow
FROM 
  equity_considerations
GROUP BY 
  tr_ej;

------------------------------------
-- Total Population (poptot_mc) for Census Tracts with Concentrated Poverty (concpov) and a High Proportion of BIPOC (pbipoc) with and without Environmental Justice Concerns (tr_ej) 
SELECT 
  tr_ej, 
  AVG(poptot_mc) AS poptot_mc, 
  COUNT(*) AS count, 
  MIN(poptot_mc) AS min_poptot_mc, 
  MAX(poptot_mc) AS max_poptot_mc, 
  ROUND(CAST(STDDEV_POP(poptot_mc) AS numeric), 2) AS std_dev_poptot_mc
FROM 
  equity_considerations
WHERE concpov = 1 AND pbipoc > 0.5
GROUP BY 
  tr_ej;

------------------------------------
-- Proportion of BIPOC (pbipoc) and Hispanic (phisppop) Population with and without Environmental Justice Concerns (tr_ej)
SELECT 
  tr_ej, 
  AVG(pbipoc + phisppop) AS minpop, 
  COUNT(*) AS count, 
  MIN(pbipoc + phisppop) AS min_minpop, 
  MAX(pbipoc + phisppop) AS max_minpop, 
  ROUND(CAST(STDDEV_POP(pbipoc + phisppop) AS numeric), 2) AS std_dev_minpop
FROM 
  equity_considerations
GROUP BY 
  tr_ej;

------------------------------------
-- Average Land Surface Temperature (avg_temp) with and without Environmental Justice Concerns (tr_ej)
SELECT 
  tr_ej, 
  AVG(avg_temp) AS avg_tmp,
  COUNT(*) AS count, 
  MIN(avg_temp) AS min_avg_temp, 
  MAX(avg_temp) AS max_avg_temp, 
  ROUND(CAST(STDDEV_POP(avg_temp) AS numeric), 2) AS std_dev_avg_temp
FROM 
  equity_considerations
GROUP BY 
  tr_ej;

------------------------------------
-- Concentrated Poverty (concpov) with and without Environmental Justice Concerns (tr_ej)
SELECT 
  tr_ej, 
  AVG(concpov) AS avg_concpov,
  COUNT(*) AS count, 
  MIN(concpov) AS min_concpov, 
  MAX(concpov) AS max_concpov, 
  ROUND(CAST(STDDEV_POP(concpov) AS numeric), 2) AS std_dev_concpov
FROM 
  equity_considerations
GROUP BY 
  tr_ej;