USE RoboticSurgeryAuditAnalytics;
GO

/* =========================================================
   INSERT DATA: Surgeons
========================================================= */

INSERT INTO Surgeons (
    SurgeonFirstName,
    SurgeonLastName,
    SpecialtyID,
    HospitalID,
    ConsultantStatus,
    YearsRoboticExperience,
    RCSICertified
)
VALUES
('Sarah', 'O''Brien', 1, 1, 'Consultant', 8, 1),
('Michael', 'Murphy', 2, 3, 'Consultant', 6, 1),
('Aoife', 'Kelly', 3, 4, 'Consultant', 5, 1),
('David', 'Ryan', 4, 2, 'Consultant', 7, 1),
('Emma', 'Walsh', 5, 5, 'Consultant', 4, 1),
('James', 'Byrne', 1, 6, 'Consultant', 9, 1),
('Niamh', 'Doyle', 2, 7, 'Consultant', 3, 0);
GO


/* =========================================================
   INSERT DATA: Patients
========================================================= */

INSERT INTO Patients (
    PatientMRN,
    Gender,
    DateOfBirth,
    County,
    BMI,
    SmokingStatus,
    ASAClassification
)
VALUES
('MRN1001', 'Male', '1965-04-12', 'Dublin', 27.4, 'Former Smoker', 'ASA II'),
('MRN1002', 'Female', '1978-09-23', 'Cork', 31.2, 'Non-Smoker', 'ASA III'),
('MRN1003', 'Male', '1959-01-14', 'Galway', 29.8, 'Current Smoker', 'ASA III'),
('MRN1004', 'Female', '1984-06-30', 'Limerick', 24.5, 'Non-Smoker', 'ASA II'),
('MRN1005', 'Male', '1970-11-11', 'Dublin', 26.1, 'Former Smoker', 'ASA II'),
('MRN1006', 'Female', '1990-02-17', 'Waterford', 22.9, 'Non-Smoker', 'ASA I'),
('MRN1007', 'Male', '1968-08-08', 'Clare', 33.7, 'Current Smoker', 'ASA III');
GO


/* =========================================================
   INSERT DATA: SurgicalCases
========================================================= */

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
VALUES
(1, 1, 1, 1, '2024-01-18', 'Robotic', 260, 190, 0, 3, 0),
(2, 6, 4, 6, '2024-02-06', 'Robotic', 195, 135, 0, 2, 0),
(3, 7, 3, 7, '2024-02-22', 'Robotic', 330, 250, 1, 8, 1),
(4, 5, 6, 5, '2024-03-11', 'Robotic', 135, 90, 0, 1, 0),
(5, 2, 2, 3, '2024-04-09', 'Robotic', 225, 165, 0, 4, 0),
(6, 3, 4, 4, '2024-05-16', 'Robotic', 175, 120, 0, 2, 0),
(7, 4, 5, 2, '2024-06-04', 'Robotic', 290, 210, 0, 5, 1);
GO


/* =========================================================
   INSERT DATA: Outcomes
========================================================= */

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
VALUES
(1, 0, 'None', 0, 0, 150, 'Clear', 'Uncomplicated recovery'),
(2, 0, 'None', 0, 0, 100, 'Not Applicable', 'Routine discharge'),
(3, 1, 'Grade III', 1, 0, 650, 'Not Applicable', 'Converted to open procedure; readmitted within 30 days'),
(4, 0, 'None', 0, 0, 80, 'Not Applicable', 'Day case recovery pathway'),
(5, 1, 'Grade II', 0, 0, 300, 'Clear', 'Post-operative infection managed with antibiotics'),
(6, 0, 'None', 0, 0, 90, 'Not Applicable', 'No complications recorded'),
(7, 1, 'Grade II', 0, 0, 420, 'Clear', 'ICU admission for monitoring');
GO


/* =========================================================
   INSERT DATA: TrainingGovernance
========================================================= */

INSERT INTO TrainingGovernance (
    SurgeonID,
    TrainingCompleted,
    SimulationHours,
    ProctorSignOff,
    AnnualReviewCompleted,
    GovernanceNotes
)
VALUES
(1, 1, 42, 1, 1, 'Fully credentialed for independent robotic practice'),
(2, 1, 36, 1, 1, 'Annual governance review completed'),
(3, 1, 30, 1, 1, 'Completed RCSI-aligned simulation and proctoring pathway'),
(4, 1, 40, 1, 1, 'Experienced robotic surgeon with completed review'),
(5, 1, 24, 1, 0, 'Annual review due this year'),
(6, 1, 50, 1, 1, 'Senior robotic surgeon and local programme lead'),
(7, 0, 18, 0, 0, 'Training pathway in progress; requires proctor sign-off');
GO