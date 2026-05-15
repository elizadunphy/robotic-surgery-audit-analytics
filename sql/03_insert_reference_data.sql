USE RoboticSurgeryAuditAnalytics;
GO

/* =========================================================
   INSERT DATA: Hospitals
========================================================= */

INSERT INTO Hospitals (
    HospitalName,
    HospitalGroup,
    County,
    HasRoboticProgramme,
    RoboticPlatform,
    ProgrammeStartYear
)
VALUES
('St Vincent''s University Hospital', 'Ireland East Hospital Group', 'Dublin', 1, 'da Vinci Xi', 2019),
('Mater Misericordiae University Hospital', 'Ireland East Hospital Group', 'Dublin', 1, 'da Vinci Xi', 2021),
('Beaumont Hospital', 'RCSI Hospitals Group', 'Dublin', 1, 'da Vinci X', 2020),
('Tallaght University Hospital', 'Dublin Midlands Hospital Group', 'Dublin', 1, 'da Vinci Xi', 2022),
('University Hospital Limerick', 'UL Hospitals Group', 'Limerick', 1, 'da Vinci Xi', 2023),
('Cork University Hospital', 'South/South West Hospital Group', 'Cork', 1, 'da Vinci Xi', 2021),
('University Hospital Galway', 'Saolta Hospital Group', 'Galway', 1, 'da Vinci X', 2022);
GO


/* =========================================================
   INSERT DATA: Specialties
========================================================= */

INSERT INTO Specialties (
    SpecialtyName,
    RCSIAligned
)
VALUES
('Urology', 1),
('Colorectal Surgery', 1),
('Gynaecology', 1),
('Thoracic Surgery', 1),
('General Surgery', 1);
GO


/* =========================================================
   INSERT DATA: Procedures
========================================================= */

INSERT INTO Procedures (
    ProcedureName,
    SpecialtyID,
    ProcedureCategory,
    TypicalLengthMinutes
)
VALUES
('Robotic Radical Prostatectomy', 1, 'Cancer Surgery', 240),
('Robotic Partial Nephrectomy', 1, 'Kidney Surgery', 210),
('Robotic Low Anterior Resection', 2, 'Colorectal Surgery', 300),
('Robotic Hysterectomy', 3, 'Gynaecology', 180),
('Robotic Lobectomy', 4, 'Thoracic Surgery', 270),
('Robotic Hernia Repair', 5, 'General Surgery', 120);
GO