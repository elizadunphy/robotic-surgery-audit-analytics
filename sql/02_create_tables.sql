USE RoboticSurgeryAuditAnalytics;
GO

/* =========================================================
   TABLE: Hospitals
========================================================= */

CREATE TABLE Hospitals (
    HospitalID INT IDENTITY(1,1) PRIMARY KEY,
    HospitalName VARCHAR(150) NOT NULL,
    HospitalGroup VARCHAR(150),
    County VARCHAR(100),
    HasRoboticProgramme BIT NOT NULL,
    RoboticPlatform VARCHAR(100),
    ProgrammeStartYear INT
);
GO


/* =========================================================
   TABLE: Specialties
========================================================= */

CREATE TABLE Specialties (
    SpecialtyID INT IDENTITY(1,1) PRIMARY KEY,
    SpecialtyName VARCHAR(100) NOT NULL,
    RCSIAligned BIT NOT NULL
);
GO


/* =========================================================
   TABLE: Procedures
========================================================= */

CREATE TABLE Procedures (
    ProcedureID INT IDENTITY(1,1) PRIMARY KEY,
    ProcedureName VARCHAR(150) NOT NULL,
    SpecialtyID INT NOT NULL,
    ProcedureCategory VARCHAR(100),
    TypicalLengthMinutes INT,

    CONSTRAINT FK_Procedures_Specialties
        FOREIGN KEY (SpecialtyID)
        REFERENCES Specialties(SpecialtyID)
);
GO


/* =========================================================
   TABLE: Surgeons
========================================================= */

CREATE TABLE Surgeons (
    SurgeonID INT IDENTITY(1,1) PRIMARY KEY,
    SurgeonFirstName VARCHAR(100) NOT NULL,
    SurgeonLastName VARCHAR(100) NOT NULL,
    SpecialtyID INT NOT NULL,
    HospitalID INT NOT NULL,
    ConsultantStatus VARCHAR(50),
    YearsRoboticExperience INT,
    RCSICertified BIT NOT NULL,

    CONSTRAINT FK_Surgeons_Specialties
        FOREIGN KEY (SpecialtyID)
        REFERENCES Specialties(SpecialtyID),

    CONSTRAINT FK_Surgeons_Hospitals
        FOREIGN KEY (HospitalID)
        REFERENCES Hospitals(HospitalID)
);
GO


/* =========================================================
   TABLE: Patients
========================================================= */

CREATE TABLE Patients (
    PatientID INT IDENTITY(1,1) PRIMARY KEY,
    PatientMRN VARCHAR(50) NOT NULL,
    Gender VARCHAR(20),
    DateOfBirth DATE,
    County VARCHAR(100),
    BMI DECIMAL(5,2),
    SmokingStatus VARCHAR(50),
    ASAClassification VARCHAR(20)
);
GO


/* =========================================================
   TABLE: SurgicalCases
========================================================= */

CREATE TABLE SurgicalCases (
    CaseID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    SurgeonID INT NOT NULL,
    ProcedureID INT NOT NULL,
    HospitalID INT NOT NULL,

    SurgeryDate DATE NOT NULL,
    SurgeryType VARCHAR(50),
    TheatreDurationMinutes INT,
    ConsoleTimeMinutes INT,

    ConvertedToOpen BIT NOT NULL,
    LengthOfStayDays INT,
    ICUAdmission BIT NOT NULL,

    CONSTRAINT FK_SurgicalCases_Patients
        FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID),

    CONSTRAINT FK_SurgicalCases_Surgeons
        FOREIGN KEY (SurgeonID)
        REFERENCES Surgeons(SurgeonID),

    CONSTRAINT FK_SurgicalCases_Procedures
        FOREIGN KEY (ProcedureID)
        REFERENCES Procedures(ProcedureID),

    CONSTRAINT FK_SurgicalCases_Hospitals
        FOREIGN KEY (HospitalID)
        REFERENCES Hospitals(HospitalID)
);
GO


/* =========================================================
   TABLE: Outcomes
========================================================= */

CREATE TABLE Outcomes (
    OutcomeID INT IDENTITY(1,1) PRIMARY KEY,
    CaseID INT NOT NULL,

    ComplicationOccurred BIT NOT NULL,
    ComplicationGrade VARCHAR(20),
    Readmission30Days BIT NOT NULL,
    Mortality30Days BIT NOT NULL,

    EstimatedBloodLossML INT,
    MarginStatus VARCHAR(50),
    OutcomeNotes VARCHAR(500),

    CONSTRAINT FK_Outcomes_SurgicalCases
        FOREIGN KEY (CaseID)
        REFERENCES SurgicalCases(CaseID)
);
GO


/* =========================================================
   TABLE: TrainingGovernance
========================================================= */

CREATE TABLE TrainingGovernance (
    GovernanceID INT IDENTITY(1,1) PRIMARY KEY,
    SurgeonID INT NOT NULL,

    TrainingCompleted BIT NOT NULL,
    SimulationHours INT,
    ProctorSignOff BIT NOT NULL,
    AnnualReviewCompleted BIT NOT NULL,
    GovernanceNotes VARCHAR(500),

    CONSTRAINT FK_TrainingGovernance_Surgeons
        FOREIGN KEY (SurgeonID)
        REFERENCES Surgeons(SurgeonID)
);
GO