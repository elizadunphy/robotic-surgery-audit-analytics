USE RoboticSurgeryAuditAnalytics;
GO

/* =========================================================
   STORED PROCEDURE:
   Get Cases By Hospital
========================================================= */

CREATE PROCEDURE sp_GetCasesByHospital
    @HospitalName VARCHAR(150)
AS
BEGIN

    SELECT
        sc.CaseID,
        sc.SurgeryDate,
        p.ProcedureName,
        s.SurgeonFirstName + ' ' + s.SurgeonLastName AS SurgeonName,
        sc.LengthOfStayDays,
        sc.ConvertedToOpen
    FROM SurgicalCases sc
    JOIN Hospitals h
        ON sc.HospitalID = h.HospitalID
    JOIN Procedures p
        ON sc.ProcedureID = p.ProcedureID
    JOIN Surgeons s
        ON sc.SurgeonID = s.SurgeonID
    WHERE h.HospitalName = @HospitalName;

END;
GO


/* =========================================================
   STORED PROCEDURE:
   Get Complication Summary
========================================================= */

CREATE PROCEDURE sp_GetComplicationSummary
AS
BEGIN

    SELECT
        p.ProcedureName,
        COUNT(o.OutcomeID) AS TotalCases,
        SUM(CASE WHEN o.ComplicationOccurred = 1 THEN 1 ELSE 0 END)
            AS Complications,
        ROUND(
            SUM(CASE WHEN o.ComplicationOccurred = 1 THEN 1 ELSE 0 END)
            * 100.0 / COUNT(o.OutcomeID),
            2
        ) AS ComplicationRatePercent
    FROM Outcomes o
    JOIN SurgicalCases sc
        ON o.CaseID = sc.CaseID
    JOIN Procedures p
        ON sc.ProcedureID = p.ProcedureID
    GROUP BY p.ProcedureName;

END;
GO


/* =========================================================
   STORED PROCEDURE:
   Get Governance Compliance Issues
========================================================= */

CREATE PROCEDURE sp_GetGovernanceComplianceIssues
AS
BEGIN

    SELECT
        s.SurgeonFirstName + ' ' + s.SurgeonLastName AS SurgeonName,
        h.HospitalName,
        tg.TrainingCompleted,
        tg.ProctorSignOff,
        tg.AnnualReviewCompleted
    FROM TrainingGovernance tg
    JOIN Surgeons s
        ON tg.SurgeonID = s.SurgeonID
    JOIN Hospitals h
        ON s.HospitalID = h.HospitalID
    WHERE
        tg.TrainingCompleted = 0
        OR tg.ProctorSignOff = 0
        OR tg.AnnualReviewCompleted = 0;

END;
GO


/* =========================================================
   TEST STORED PROCEDURES
========================================================= */

EXEC sp_GetCasesByHospital
    @HospitalName = 'Beaumont Hospital';
GO

EXEC sp_GetComplicationSummary;
GO

EXEC sp_GetGovernanceComplianceIssues;
GO