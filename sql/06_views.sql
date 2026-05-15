USE RoboticSurgeryAuditAnalytics;
GO

/* =========================================================
   VIEW: Robotic Case Summary
========================================================= */

CREATE VIEW vw_RoboticCaseSummary AS
SELECT
    sc.CaseID,
    sc.SurgeryDate,
    h.HospitalName,
    h.HospitalGroup,
    sp.SpecialtyName,
    p.ProcedureName,
    s.SurgeonFirstName + ' ' + s.SurgeonLastName AS SurgeonName,
    sc.SurgeryType,
    sc.TheatreDurationMinutes,
    sc.ConsoleTimeMinutes,
    sc.ConvertedToOpen,
    sc.LengthOfStayDays,
    sc.ICUAdmission
FROM SurgicalCases sc
JOIN Hospitals h
    ON sc.HospitalID = h.HospitalID
JOIN Procedures p
    ON sc.ProcedureID = p.ProcedureID
JOIN Specialties sp
    ON p.SpecialtyID = sp.SpecialtyID
JOIN Surgeons s
    ON sc.SurgeonID = s.SurgeonID;
GO


/* =========================================================
   VIEW: Complication Analysis
========================================================= */

CREATE VIEW vw_ComplicationAnalysis AS
SELECT
    sc.CaseID,
    h.HospitalName,
    p.ProcedureName,
    o.ComplicationOccurred,
    o.ComplicationGrade,
    o.Readmission30Days,
    o.Mortality30Days,
    o.EstimatedBloodLossML
FROM Outcomes o
JOIN SurgicalCases sc
    ON o.CaseID = sc.CaseID
JOIN Hospitals h
    ON sc.HospitalID = h.HospitalID
JOIN Procedures p
    ON sc.ProcedureID = p.ProcedureID;
GO


/* =========================================================
   VIEW: Governance Compliance
========================================================= */

CREATE VIEW vw_GovernanceCompliance AS
SELECT
    s.SurgeonFirstName + ' ' + s.SurgeonLastName AS SurgeonName,
    sp.SpecialtyName,
    h.HospitalName,
    tg.TrainingCompleted,
    tg.ProctorSignOff,
    tg.AnnualReviewCompleted,
    tg.SimulationHours
FROM TrainingGovernance tg
JOIN Surgeons s
    ON tg.SurgeonID = s.SurgeonID
JOIN Specialties sp
    ON s.SpecialtyID = sp.SpecialtyID
JOIN Hospitals h
    ON s.HospitalID = h.HospitalID;
GO


/* =========================================================
   VIEW: Hospital Performance
========================================================= */

CREATE VIEW vw_HospitalPerformance AS
SELECT
    h.HospitalName,
    COUNT(sc.CaseID) AS TotalCases,
    AVG(sc.LengthOfStayDays * 1.0) AS AverageLengthOfStay,
    SUM(CASE WHEN sc.ConvertedToOpen = 1 THEN 1 ELSE 0 END) AS ConversionToOpenCases
FROM SurgicalCases sc
JOIN Hospitals h
    ON sc.HospitalID = h.HospitalID
GROUP BY h.HospitalName;
GO


/* =========================================================
   TEST VIEWS
========================================================= */

SELECT * FROM vw_RoboticCaseSummary;
SELECT * FROM vw_ComplicationAnalysis;
SELECT * FROM vw_GovernanceCompliance;
SELECT * FROM vw_HospitalPerformance;
GO