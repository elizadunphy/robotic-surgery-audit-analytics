USE RoboticSurgeryAuditAnalytics;
GO

/* =========================================================
   ADVANCED QUERY 1
   Rank Hospitals by Total Robotic Cases
========================================================= */

SELECT
    h.HospitalName,
    COUNT(sc.CaseID) AS TotalCases,

    RANK() OVER (
        ORDER BY COUNT(sc.CaseID) DESC
    ) AS HospitalRank

FROM SurgicalCases sc
JOIN Hospitals h
    ON sc.HospitalID = h.HospitalID

GROUP BY h.HospitalName;
GO


/* =========================================================
   ADVANCED QUERY 2
   Running Total of Surgical Cases
========================================================= */

SELECT
    SurgeryDate,

    COUNT(CaseID) AS CasesPerDay,

    SUM(COUNT(CaseID)) OVER (
        ORDER BY SurgeryDate
    ) AS RunningTotalCases

FROM SurgicalCases

GROUP BY SurgeryDate;
GO


/* =========================================================
   ADVANCED QUERY 3
   Average Theatre Duration by Specialty
========================================================= */

SELECT
    sp.SpecialtyName,

    AVG(sc.TheatreDurationMinutes * 1.0)
        AS AverageTheatreDuration

FROM SurgicalCases sc
JOIN Procedures p
    ON sc.ProcedureID = p.ProcedureID
JOIN Specialties sp
    ON p.SpecialtyID = sp.SpecialtyID

GROUP BY sp.SpecialtyName

ORDER BY AverageTheatreDuration DESC;
GO


/* =========================================================
   ADVANCED QUERY 4
   CTE - High Risk Cases
========================================================= */

WITH HighRiskCases AS (

    SELECT
        sc.CaseID,
        h.HospitalName,
        p.ProcedureName,
        sc.LengthOfStayDays,
        o.ComplicationOccurred,
        o.Readmission30Days

    FROM SurgicalCases sc
    JOIN Hospitals h
        ON sc.HospitalID = h.HospitalID
    JOIN Procedures p
        ON sc.ProcedureID = p.ProcedureID
    JOIN Outcomes o
        ON sc.CaseID = o.CaseID

    WHERE
        sc.LengthOfStayDays >= 5
        OR o.ComplicationOccurred = 1
        OR o.Readmission30Days = 1
)

SELECT *
FROM HighRiskCases;
GO