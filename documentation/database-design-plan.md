# Database Design Plan

## Project Design Approach

This project is designed as a simulated healthcare audit and analytics system for robotic-assisted surgery.

The database will support the recording, monitoring and reporting of surgical activity, patient outcomes, surgeon training, and governance oversight.

The design follows a relational database structure, with separate tables for hospitals, specialties, procedures, surgeons, patients, surgical cases, outcomes, and training/governance records.

---

## Core Design Principles

- Use structured relational tables
- Avoid storing repeated text where lookup tables are more appropriate
- Use primary keys and foreign keys to link related data
- Use synthetic and anonymised data only
- Keep the design realistic but manageable for a portfolio project
- Support reporting through SQL queries and Power BI dashboards
- Align the data model with healthcare audit, governance, and operational reporting

---

## Proposed Tables

### 1. Hospitals

Stores details of hospitals included in the simulated audit.

Example fields:

- HospitalID
- HospitalName
- HospitalGroup
- County
- HospitalType
- HasRoboticSurgeryProgramme

---

### 2. Specialties

Stores the surgical specialties included in the audit.

Example fields:

- SpecialtyID
- SpecialtyName

---

### 3. Procedures

Stores robotic-assisted and comparator surgical procedures.

Example fields:

- ProcedureID
- ProcedureName
- SpecialtyID
- ProcedureCategory
- ApproachType

---

### 4. Surgeons

Stores details of surgeons involved in procedures.

Example fields:

- SurgeonID
- SurgeonName
- SpecialtyID
- HospitalID
- RoboticTrainingStatus
- AccreditationDate

---

### 5. Patients

Stores synthetic anonymised patient-level data.

Example fields:

- PatientID
- AgeGroup
- Sex
- County
- ASAClass

---

### 6. SurgicalCases

Main table recording each surgical case.

Example fields:

- CaseID
- PatientID
- HospitalID
- SurgeonID
- ProcedureID
- SurgeryDate
- SurgicalApproach
- PlannedApproach
- ConvertedToOpen
- OperatingTimeMinutes

---

### 7. Outcomes

Stores post-operative outcome measures.

Example fields:

- OutcomeID
- CaseID
- LengthOfStayDays
- ComplicationRecorded
- ComplicationGrade
- Readmitted30Days
- ReturnedToTheatre
- Mortality30Days

---

### 8. TrainingGovernance

Stores governance and training-related records.

Example fields:

- GovernanceID
- SurgeonID
- TrainingCompleted
- SimulationTrainingCompleted
- ProctoredCasesCompleted
- AuditReviewCompleted
- LastGovernanceReviewDate

---

## Planned Reporting Questions

The database should support reporting on:

- Robotic surgery volume by hospital
- Robotic surgery volume by specialty
- Procedure mix across hospitals
- Complication rates by procedure and specialty
- Length of stay by surgical approach
- Conversion rates from robotic to open surgery
- 30-day readmission rates
- Surgeon training and governance compliance
- Hospital-level audit readiness
- Trends in surgical activity over time

---

## Notes

This project uses synthetic data only. It is designed for portfolio and educational purposes and does not contain real patient data.
