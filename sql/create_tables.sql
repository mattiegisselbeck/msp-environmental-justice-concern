/* 
Title: Assessing Environmental Justice Concern in the Twin Cities Metro Area
Author(s): Mattie Gisselbeck
*/
------------------------------------
CREATE TABLE tcma_population_demographics (
  tr10 INT,
  cty_prmry VARCHAR,
  pbipoc INT,
  phispop INT,
  poptot_mc INT
);

\copy tcma_population_demographics from '/Users/mattiegisselbeck/Documents/tcma_population_demographics.csv' with header CSV;

------------------------------------
CREATE TABLE tcma_socioeconomic_demographics (
  tr10 INT,
  concpov INT,
  tr_eda BOOLEAN,
  mdhhincnow INT
);

\copy tcma_population_demographics from '/Users/mattiegisselbeck/Documents/tcma_population_demographics.csv' with header CSV;

------------------------------------
CREATE TABLE tcma_environmental_quality (
  tr10 INT,
  ghg_com_pe INT,
  avg_temp INT,
  tr_ej BOOLEAN,
  env_pm25 INT
);

\copy tcma_environmental_quality from '/Users/mattiegisselbeck/Documents/tcma_environmental_quality.csv' with header CSV;

------------------------------------
CREATE TABLE msp_historical_discrimination (
  tr10 INT,
  holc_pred BOOLEAN,
  holc_pylw BOOLEAN,
  rrcov_number INT
);

\copy msp_historical_discrimination from '/Users/mattiegisselbeck/Documents/msp_historical_discrimination.csv' with header CSV;


