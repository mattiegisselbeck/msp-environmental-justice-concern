-- Assessing Environmental Justice Concern in Twin Cities Metro Area

/* Query 1
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
Environmental Quality in Areas of Red Zones (holc_pred) and Concentrated Poverty (concpov) in Minneapolis and St. Paul */
CREATE TABLE environmental_quality AS
WITH scores AS (
    SELECT
        ctu_prmry,
        tr10,
        tr_ej,
        holc_pred,
        AVG(ghg_com_pe) * 0.3
        + AVG(avg_temp) * 0.2
        + AVG(env_pm25) * 0.4
        + AVG(env_dslpm) * 0.4 AS environmental_quality_score
    FROM equity_considerations
    WHERE tr10 IS NOT NULL
    GROUP BY ctu_prmry, concpov, tr10, tr_ej, holc_pred
)

SELECT *
FROM scores;

/* Query 3
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

/*  Query 4 
Linear Regression Model for Fine Particulate Matter PM 2.5 (env_pm2) and Total Population (poptot_mc) */
SELECT
    regr_slope(env_pm25, poptot_mc) AS slope,
    regr_intercept(env_pm25, poptot_mc) AS intercept
FROM
    equity_considerations
WHERE
    tr_ej = 1
    AND tr_eda = 1
    AND pbipoc > 0.50
    AND holc_pylw > 0.1
    AND holc_pred > 0.1
    AND concpov = 1;