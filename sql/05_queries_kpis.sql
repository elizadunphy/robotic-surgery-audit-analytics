USE RoboticSurgeryAuditAnalytics;
GO

/* =========================================================
   KPI QUERY 1
   Total Robotic Cases by Hospital
========================================================= */

SELECT
    h.HospitalName,
    COUNT(sc.CaseID) AS TotalCases
FROM SurgicalCases sc
JOIN Hospitals h
    ON sc.HospitalID = h.HospitalID
GROUP BY h.HospitalName
ORDER BY TotalCases DESC;
GO


/* =========================================================
   KPI QUERY 2
   Average Length of Stay by Procedure
========================================================= */

SELECT
    p.ProcedureName,
    AVG(sc.LengthOfStayDays * 1.0) AS AverageLengthOfStay
FROM SurgicalCases sc
JOIN Procedures p
    ON sc.ProcedureID = p.ProcedureID
GROUP BY p.ProcedureName
ORDER BY AverageLengthOfStay DESC;
GO


/* =========================================================
   KPI QUERY 3
   Complication Rate
========================================================= */

SELECT
    COUNT(CASE WHEN ComplicationOccurred = 1 THEN 1 END) * 100.0
    / COUNT(*) AS ComplicationRatePercent
FROM Outcomes;
GO


/* =========================================================
   KPI QUERY 4
   Conversion to Open Surgery Rate
========================================================= */

SELECT
    COUNT(CASE WHEN ConvertedToOpen = 1 THEN 1 END) * 100.0
    / COUNT(*) AS ConversionToOpenPercent
FROM SurgicalCases;
GO


/* =========================================================
   KPI QUERY 5
   Surgeons Without Completed Governance Review
========================================================= */

SELECT
    s.SurgeonFirstName,
    s.SurgeonLastName,
    tg.AnnualReviewCompleted
FROM TrainingGovernance tg
JOIN Surgeons s
    ON tg.SurgeonID = s.SurgeonID
WHERE tg.AnnualReviewCompleted = 0;
GO