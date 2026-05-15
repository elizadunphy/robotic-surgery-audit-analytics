# Table Structure Design

## Overview

This document defines the proposed relational database structure for the robotic surgery audit analytics project.

The database is designed to support healthcare operational reporting, governance monitoring, and surgical audit analytics.

---

# 1. Hospitals

Stores hospital-level information.

| Field Name | Data Type | Notes |
|---|---|---|
| HospitalID | INT | Primary Key |
| HospitalName | VARCHAR | Hospital name |
| HospitalGroup | VARCHAR | Regional/hospital group |
| County | VARCHAR | Irish county |
| ProgrammeMaturity | VARCHAR | Emerging / Established / High-Volume / National Training Centre |
| HasRoboticProgramme | BIT | Yes/No |

---

# 2. Specialties

Stores surgical specialty information.

| Field Name | Data Type | Notes |
|---|---|---|
| SpecialtyID | INT | Primary Key |
| SpecialtyName | VARCHAR | Specialty name |

---

# 3. Procedures

Stores surgical procedure information.

| Field Name | Data Type | Notes |
|---|---|---|
| ProcedureID | INT | Primary Key |
| ProcedureName | VARCHAR | Procedure description |
| SpecialtyID | INT | Foreign Key |
| ProcedureCategory | VARCHAR | Major/minor procedure |
| ApproachType | VARCHAR | Robotic / Laparoscopic / Open |

---

# 4. RoboticPlatforms

Stores robotic surgery platform information.

| Field Name | Data Type | Notes |
|---|---|---|
| PlatformID | INT | Primary Key |
| PlatformName | VARCHAR | da Vinci Xi / da Vinci X |
| Manufacturer | VARCHAR | Platform manufacturer |

---

# 5. Surgeons

Stores surgeon-level information.

| Field Name | Data Type | Notes |
|---|---|---|
| SurgeonID | INT | Primary Key |
| SurgeonCode | VARCHAR | Synthetic anonymised identifier |
| SpecialtyID | INT | Foreign Key |
| HospitalID | INT | Foreign Key |
| ConsultantGrade | VARCHAR | Consultant / Fellow |
| RoboticTrainingStatus | VARCHAR | Training status |
| AccreditationDate | DATE | Accreditation date |

---

# 6. Patients

Stores synthetic anonymised patient data.

| Field Name | Data Type | Notes |
|---|---|---|
| PatientID | INT | Primary Key |
| PatientCode | VARCHAR | Synthetic patient identifier |
| AgeGroup | VARCHAR | Age category |
| Sex | VARCHAR | M/F |
| County | VARCHAR | Irish county |
| ASAClass | VARCHAR | Anaesthetic risk classification |

---

# 7. SurgicalCases

Main fact table storing surgical activity.

| Field Name | Data Type | Notes |
|---|---|---|
| CaseID | INT | Primary Key |
| PatientID | INT | Foreign Key |
| HospitalID | INT | Foreign Key |
| SurgeonID | INT | Foreign Key |
| ProcedureID | INT | Foreign Key |
| PlatformID | INT | Foreign Key |
| SurgeryDate | DATE | Procedure date |
| PlannedApproach | VARCHAR | Planned surgery type |
| ActualApproach | VARCHAR | Final surgery type |
| ConvertedToOpen | BIT | Yes/No |
| OperatingTimeMinutes | INT | Theatre duration |

---

# 8. Outcomes

Stores post-operative outcomes.

| Field Name | Data Type | Notes |
|---|---|---|
| OutcomeID | INT | Primary Key |
| CaseID | INT | Foreign Key |
| LengthOfStayDays | INT | Inpatient stay |
| ComplicationRecorded | BIT | Yes/No |
| ComplicationGrade | VARCHAR | Severity grading |
| Readmitted30Days | BIT | Yes/No |
| ReturnedToTheatre | BIT | Yes/No |
| Mortality30Days | BIT | Yes/No |

---

# 9. TrainingGovernance

Stores governance and training compliance data.

| Field Name | Data Type | Notes |
|---|---|---|
| GovernanceID | INT | Primary Key |
| SurgeonID | INT | Foreign Key |
| TrainingCompleted | BIT | Yes/No |
| SimulationTrainingCompleted | BIT | Yes/No |
| ProctoredCasesCompleted | INT | Number completed |
| GovernanceReviewCompleted | BIT | Yes/No |
| LastGovernanceReviewDate | DATE | Review date |

---

# Relationship Summary

| Parent Table | Child Table | Relationship |
|---|---|---|
| Hospitals | Surgeons | One-to-Many |
| Hospitals | SurgicalCases | One-to-Many |
| Specialties | Procedures | One-to-Many |
| Specialties | Surgeons | One-to-Many |
| Procedures | SurgicalCases | One-to-Many |
| Surgeons | SurgicalCases | One-to-Many |
| Patients | SurgicalCases | One-to-Many |
| SurgicalCases | Outcomes | One-to-One |
| Surgeons | TrainingGovernance | One-to-Many |

---

# Notes

The database structure is designed to balance realism, reporting capability, and manageable project scope for portfolio purposes.
