USE RoboticSurgeryAuditAnalytics;
GO

/* =========================================================
   BULK SYNTHETIC DATA INSERT
   Adds additional patients, surgical cases and outcomes
   for analytics and visualisation purposes
========================================================= */

DECLARE @Counter INT = 8;
DECLARE @MaxPatients INT = 100;

/* =========================================================
   INSERT ADDITIONAL PATIENTS
========================================================= */

WHILE @Counter <= @MaxPatients
BEGIN
    INSERT INTO Patients (
        PatientMRN,
        Gender,
        DateOfBirth,
        County,
        BMI,
        SmokingStatus,
        ASAClassification
    )
    VALUES (
        CONCAT('MRN', 1000 + @Counter),
        CASE WHEN @Counter % 2 = 0 THEN 'Female' ELSE 'Male' END,
        DATEADD(YEAR, - (35 + (@Counter % 45)), '2024-01-01'),
        CASE @Counter % 7
            WHEN 0 THEN 'Dublin'
            WHEN 1 THEN 'Cork'
            WHEN 2 THEN 'Galway'
            WHEN 3 THEN 'Limerick'
            WHEN 4 THEN 'Waterford'
            WHEN 5 THEN 'Clare'
            ELSE 'Kildare'
        END,
        CAST(22 + (@Counter % 14) + ((@Counter % 10) * 0.1) AS DECIMAL(5,2)),
        CASE @Counter % 3
            WHEN 0 THEN 'Non-Smoker'
            WHEN 1 THEN 'Former Smoker'
            ELSE 'Current Smoker'
        END,
        CASE @Counter % 4
            WHEN 0 THEN 'ASA I'
            WHEN 1 THEN 'ASA II'
            WHEN 2 THEN 'ASA III'
            ELSE 'ASA II'
        END
    );

    SET @Counter = @Counter + 1;
END;
GO


/* =========================================================
   INSERT ADDITIONAL SURGICAL CASES
========================================================= */

DECLARE @CaseCounter INT = 8;
DECLARE @MaxCases INT = 100;

WHILE @CaseCounter <= @MaxCases
BEGIN
    INSERT INTO SurgicalCases (
        PatientID,
        SurgeonID,
        ProcedureID,
        HospitalID,
        SurgeryDate,
        SurgeryType,
        TheatreDurationMinutes,
        ConsoleTimeMinutes,
        ConvertedToOpen,
        LengthOfStayDays,
        ICUAdmission
    )
    VALUES (
        @CaseCounter,
        ((@CaseCounter - 1) % 7) + 1,
        ((@CaseCounter - 1) % 6) + 1,
        ((@CaseCounter - 1) % 7) + 1,
        DATEADD(DAY, @CaseCounter * 5, '2024-01-01'),
        'Robotic',
        120 + ((@CaseCounter % 8) * 25),
        80 + ((@CaseCounter % 7) * 20),
        CASE WHEN @CaseCounter % 18 = 0 THEN 1 ELSE 0 END,
        CASE 
            WHEN @CaseCounter % 18 = 0 THEN 8
            WHEN @CaseCounter % 11 = 0 THEN 6
            WHEN @CaseCounter % 5 = 0 THEN 4
            ELSE 2 + (@CaseCounter % 3)
        END,
        CASE WHEN @CaseCounter % 20 = 0 THEN 1 ELSE 0 END
    );

    SET @CaseCounter = @CaseCounter + 1;
END;
GO


/* =========================================================
   INSERT ADDITIONAL OUTCOMES
========================================================= */

DECLARE @OutcomeCounter INT = 8;
DECLARE @MaxOutcomes INT = 100;

WHILE @OutcomeCounter <= @MaxOutcomes
BEGIN
    INSERT INTO Outcomes (
        CaseID,
        ComplicationOccurred,
        ComplicationGrade,
        Readmission30Days,
        Mortality30Days,
        EstimatedBloodLossML,
        MarginStatus,
        OutcomeNotes
    )
    VALUES (
        @OutcomeCounter,
        CASE WHEN @OutcomeCounter % 9 = 0 THEN 1 ELSE 0 END,
        CASE 
            WHEN @OutcomeCounter % 27 = 0 THEN 'Grade III'
            WHEN @OutcomeCounter % 9 = 0 THEN 'Grade II'
            ELSE 'None'
        END,
        CASE WHEN @OutcomeCounter % 14 = 0 THEN 1 ELSE 0 END,
        CASE WHEN @OutcomeCounter % 95 = 0 THEN 1 ELSE 0 END,
        80 + ((@OutcomeCounter % 12) * 45),
        CASE 
            WHEN @OutcomeCounter % 4 = 0 THEN 'Clear'
            WHEN @OutcomeCounter % 4 = 1 THEN 'Not Applicable'
            WHEN @OutcomeCounter % 4 = 2 THEN 'Close'
            ELSE 'Clear'
        END,
        CASE 
            WHEN @OutcomeCounter % 27 = 0 THEN 'Major complication requiring escalation'
            WHEN @OutcomeCounter % 14 = 0 THEN 'Readmission within 30 days'
            WHEN @OutcomeCounter % 9 = 0 THEN 'Post-operative complication recorded'
            ELSE 'Routine recovery'
        END
    );

    SET @OutcomeCounter = @OutcomeCounter + 1;
END;
GO


/* =========================================================
   FINAL RECORD COUNTS
========================================================= */

SELECT 'Patients' AS TableName, COUNT(*) AS RecordCount FROM Patients
UNION ALL
SELECT 'SurgicalCases', COUNT(*) FROM SurgicalCases
UNION ALL
SELECT 'Outcomes', COUNT(*) FROM Outcomes
UNION ALL
SELECT 'Hospitals', COUNT(*) FROM Hospitals
UNION ALL
SELECT 'Surgeons', COUNT(*) FROM Surgeons
UNION ALL
SELECT 'Procedures', COUNT(*) FROM Procedures;
GO