-- Assessing Environmental Justice Concern in Twin Cities Metro Area

/* Query 1
Spatial Analysis
Environmental Quality in Areas of Red Zones (holc_pred) and Concentrated Poverty (concpov) in Minneapolis */
SELECT
    equity_considerations.tr10,
    equity_considerations.ctu_prmry,
    equity_considerations_geom.geom_st,
    environmental_quality.environmental_quality_score
FROM equity_considerations
INNER JOIN equity_considerations_geom
    ON equity_considerations.tr10 = equity_considerations_geom.tr10
INNER JOIN environmental_quality
    ON equity_considerations.tr10 = environmental_quality.tr10
WHERE environmental_quality.environmental_quality_score > 26.5
GROUP BY
    environmental_quality.environmental_quality_score, equity_considerations.ctu_prmry, equity_considerations_geom.geom_st, equity_considerations.env_pm25, equity_considerations.avg_temp, equity_considerations.pbipoc, equity_considerations.concpov, equity_considerations.tr10;


/* Query 2
Summary Statistics */
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


/* Query 3
Environmental Quality Score
Environmental Quality in Areas of Red Zones (holc_pred) and Concentrated Poverty (concpov) in Minneapolis and St. Paul */
CREATE TABLE tcma_environmental_quality AS
WITH scores AS (
    SELECT
		ctu_prmry,
        tr10,
        tr_ej,
        holc_pred,
		ROUND(((0.20 * (100 - avg_temp)) + (0.20 * (100 - env_cancer)) + (0.20 * (100 - (ghg_com_pe/10))) + (0.20 * (env_pm25/12)) + (0.20 * (100 - (env_dslpm/40))))) AS env_qs
    FROM equity_considerations
    WHERE tr10 IS NOT NULL
    GROUP BY ctu_prmry, avg_temp, ghg_com_pe, env_cancer, env_pm25, concpov, tr10, env_dslpm, tr_ej, holc_pred, env_qs
)

SELECT *
FROM scores;


/* Query 4
Environmental Justice Score (Prediction)
Identifying Areas of Environmental Concern without the tr_ej Column */
SELECT
    tr10,
    tr_ej,
    ctu_prmry,
    CASE
        WHEN avg_temp > AVG(avg_temp) THEN 1
        ELSE 0
    END
    + CASE
        WHEN concpov = 1 THEN 1 ELSE 0
    END
    + CASE
        WHEN holc_pylw + holc_pred >= 0.1 THEN 3 ELSE 0
    END
    + CASE
        WHEN env_pm25 > AVG(env_pm25) THEN 1 ELSE 0
    END
    + CASE
        WHEN tr_eda = 1 THEN 1 ELSE 0
    END
    + CASE
        WHEN pbipoc + phisppop >= 0.5 THEN 2 ELSE 0
    END AS environmental_justice_score
FROM
    equity_considerations
WHERE tr10 IS NOT NULL
GROUP BY
    env_pm25, ctu_prmry, tr_ej, holc_pylw, tr_eda, holc_pred, avg_temp, phisppop, pbipoc, concpov, tr10;
