USE RoboticSurgeryAuditAnalytics;
GO

/* =========================================================
   VIEW: Dashboard Dataset
   Flattened reporting dataset for Power BI / Tableau
========================================================= */

CREATE VIEW vw_DashboardDataset AS

SELECT

    sc.CaseID,
    sc.SurgeryDate,
    YEAR(sc.SurgeryDate) AS SurgeryYear,
    MONTH(sc.SurgeryDate) AS SurgeryMonth,

    h.HospitalName,
    h.HospitalGroup,
    h.County AS HospitalCounty,

    sp.SpecialtyName,
    p.ProcedureName,
    p.ProcedureCategory,

    s.SurgeonFirstName + ' ' + s.SurgeonLastName
        AS SurgeonName,

    pt.Gender,
    pt.County AS PatientCounty,
    pt.BMI,
    pt.SmokingStatus,
    pt.ASAClassification,

    sc.TheatreDurationMinutes,
    sc.ConsoleTimeMinutes,
    sc.LengthOfStayDays,
    sc.ConvertedToOpen,
    sc.ICUAdmission,

    o.ComplicationOccurred,
    o.ComplicationGrade,
    o.Readmission30Days,
    o.Mortality30Days,
    o.EstimatedBloodLossML,
    o.MarginStatus,

    tg.TrainingCompleted,
    tg.ProctorSignOff,
    tg.AnnualReviewCompleted,
    tg.SimulationHours

FROM SurgicalCases sc

JOIN Hospitals h
    ON sc.HospitalID = h.HospitalID

JOIN Procedures p
    ON sc.ProcedureID = p.ProcedureID

JOIN Specialties sp
    ON p.SpecialtyID = sp.SpecialtyID

JOIN Surgeons s
    ON sc.SurgeonID = s.SurgeonID

JOIN Patients pt
    ON sc.PatientID = pt.PatientID

JOIN Outcomes o
    ON sc.CaseID = o.CaseID

JOIN TrainingGovernance tg
    ON sc.SurgeonID = tg.SurgeonID;

GO


/* =========================================================
   TEST EXPORT VIEW
========================================================= */

SELECT *
FROM vw_DashboardDataset;
GO