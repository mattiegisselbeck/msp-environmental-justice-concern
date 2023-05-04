-- Assessing Environmental Justice Concern in the Twin Cities Metro Area

------------------------------------
-- Average Population of Census Tracts with and without Environmental Justice Concerns (tr_ej) 
SELECT tr_ej, AVG(poptot_mc) AS avg_population
FROM environmental_justice
GROUP BY tr_ej;

------------------------------------
-- Average Median Household Income (mdhhincnow) Census Tracts with and without Environmental Justice Concerns (tr_ej) 
SELECT tr_ej, AVG(mdhhincnow) AS avg_income
FROM equity_considerations
GROUP BY tr_ej;

------------------------------------
-- Total Population (poptot_mc) for Census Tracts with Concentrated Poverty (concpov) and a High Proportion of BIPOC (pbipoc)
SELECT ctu_prmry, SUM(poptot_mc) AS total_population
FROM equity_considerations
WHERE concpov = 1 AND pbipoc > 0.1
GROUP BY ctu_prmry

------------------------------------
-- Average Proportion of BIPOC (pbipoc), and Hispanic or Latinx (phisppop) in Areas of Environmental Justice Concern (tr_ej)
SELECT tr_ej, AVG(pbipoc) AS avg_pbipoc, AVG(phisppop) AS avg_phisppop
FROM environmental_justice
GROUP BY tr_ej;

------------------------------------
-- Average Temperature by Areas of Environmental Justice Concern (tr_ej)
SELECT tr_ej, AVG(avg_temp) AS avg_temp
FROM environmental_justice
GROUP BY tr_ej;

