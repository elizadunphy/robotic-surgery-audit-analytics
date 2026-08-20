USE RoboticSurgeryAuditAnalytics;

GO

/* =========================================================

DATA QUALITY CHECK 1

Duplicate Patient MRNs

========================================================= */

SELECT

    PatientMRN,

    COUNT(*) AS RecordCount

FROM Patients

GROUP BY PatientMRN

HAVING COUNT(*) > 1;

GO

/* =========================================================

DATA QUALITY CHECK 2

Missing Important Patient Information

========================================================= */

SELECT PatientID, PatientMRN, Gender, DateOfBirth, BMI, ASAClassification
FROM Patients
WHERE PatientMRN IS NULL
OR DateOfBirth IS NULL
OR ASAClassification IS NULL;

GO

/* =========================================================

DATA QUALITY CHECK 3

Implausible Patient Values

========================================================= */

SELECT PatientID, PatientMRN, DateOfBirth, BMI
FROM Patients
WHERE DateOfBirth > GETDATE()
OR BMI <= 0
OR BMI > 80;

GO

/* =========================================================

DATA QUALITY CHECK 4

Invalid Surgical Case Values

========================================================= */

SELECT CaseID, SurgeryDate, TheatreDurationMinutes, ConsoleTimeMinutes, LengthOfStayDays
FROM SurgicalCases
WHERE SurgeryDate > GETDATE()
OR TheatreDurationMinutes <= 0
OR ConsoleTimeMinutes < 0
OR LengthOfStayDays < 0;

GO

/* =========================================================

DATA QUALITY CHECK 5

Console Time Greater Than Theatre Time

========================================================= */

SELECT CaseID, TheatreDurationMinutes, ConsoleTimeMinutes
FROM SurgicalCases
WHERE ConsoleTimeMinutes > TheatreDurationMinutes;

GO

/* =========================================================

DATA QUALITY CHECK 6

Surgical Cases Without an Outcome Record

========================================================= */

SELECT sc.CaseID, sc.PatientID, sc.HospitalID, sc.SurgeryDate
FROM SurgicalCases sc
LEFT JOIN Outcomes o
    ON sc.CaseID = o.CaseID
WHERE o.CaseID IS NULL;

GO

/* =========================================================

DATA QUALITY CHECK 7

Duplicate Outcome Records for the Same Case

========================================================= */

SELECT CaseID, COUNT(*) AS OutcomeRecordCount
FROM Outcomes
GROUP BY CaseID
HAVING COUNT(*) > 1;

GO

/* =========================================================

DATA QUALITY CHECK 8

Complication Data Consistency

========================================================= */

SELECT OutcomeID, CaseID, ComplicationOccurred, ComplicationGrade
FROM Outcomes
WHERE ComplicationOccurred = 0
AND ComplicationGrade IS NOT NULL;

GO

/* =========================================================

DATA QUALITY CHECK 9

Complication Recorded Without a Grade

========================================================= */

SELECT OutcomeID, CaseID, ComplicationOccurred, ComplicationGrade
FROM Outcomes
WHERE ComplicationOccurred = 1
AND ComplicationGrade IS NULL;

GO

/* =========================================================

DATA QUALITY CHECK 10

Invalid Outcome Values

========================================================= */

SELECT OutcomeID, CaseID, EstimatedBloodLossML
FROM Outcomes
WHERE EstimatedBloodLossML < 0;

GO

/* =========================================================

DATA QUALITY CHECK 11

Surgeons Without Governance Records

========================================================= */

SELECT s.SurgeonID, s.SurgeonFirstName, s.SurgeonLastName, s.HospitalID
FROM Surgeons s
LEFT JOIN TrainingGovernance tg
    ON s.SurgeonID = tg.SurgeonID
WHERE tg.SurgeonID IS NULL;

GO

/* =========================================================

DATA QUALITY CHECK 12

Incomplete Governance Requirements

========================================================= */

SELECT GovernanceID, SurgeonID, TrainingCompleted, SimulationHours,
       ProctorSignOff, AnnualReviewCompleted
FROM TrainingGovernance
WHERE TrainingCompleted = 0
OR ProctorSignOff = 0
OR AnnualReviewCompleted = 0
OR SimulationHours IS NULL
OR SimulationHours < 0;

GO

/* =========================================================

DATA QUALITY CHECK 13

Summary of Key Data Quality Issues

========================================================= */

SELECT 'Duplicate Patient MRNs' AS DataQualityCheck, COUNT(*) AS IssueCount
FROM (
    SELECT PatientMRN
    FROM Patients
    GROUP BY PatientMRN
    HAVING COUNT(*) > 1
) d

UNION ALL

SELECT 'Cases Without Outcomes', COUNT(*)
FROM SurgicalCases sc
LEFT JOIN Outcomes o
    ON sc.CaseID = o.CaseID
WHERE o.CaseID IS NULL

UNION ALL

SELECT 'Duplicate Outcome Records', COUNT(*)
FROM (
    SELECT CaseID
    FROM Outcomes
    GROUP BY CaseID
    HAVING COUNT(*) > 1
) d

UNION ALL

SELECT 'Surgeons Without Governance Records', COUNT(*)
FROM Surgeons s
LEFT JOIN TrainingGovernance tg
    ON s.SurgeonID = tg.SurgeonID
WHERE tg.SurgeonID IS NULL;

GO
