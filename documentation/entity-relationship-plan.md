# Entity Relationship Plan

## Overview

This document defines the planned relationships between tables in the robotic surgery audit analytics database.

The database uses a relational structure where lookup and reference tables connect to the main surgical activity table.

The main fact table is SurgicalCases.

---

# Core Relationship Model

## Hospitals

One hospital can have many surgeons.

One hospital can have many surgical cases.

Relationship:
- Hospitals.HospitalID → Surgeons.HospitalID
- Hospitals.HospitalID → SurgicalCases.HospitalID

---

## Specialties

One specialty can have many procedures.

One specialty can have many surgeons.

Relationship:
- Specialties.SpecialtyID → Procedures.SpecialtyID
- Specialties.SpecialtyID → Surgeons.SpecialtyID

---

## Procedures

One procedure can appear in many surgical cases.

Relationship:
- Procedures.ProcedureID → SurgicalCases.ProcedureID

---

## RoboticPlatforms

One robotic platform can be used in many surgical cases.

Relationship:
- RoboticPlatforms.PlatformID → SurgicalCases.PlatformID

---

## Surgeons

One surgeon can perform many surgical cases.

One surgeon can have many governance/training records.

Relationship:
- Surgeons.SurgeonID → SurgicalCases.SurgeonID
- Surgeons.SurgeonID → TrainingGovernance.SurgeonID

---

## Patients

One patient can have one or more surgical cases in the synthetic dataset.

Relationship:
- Patients.PatientID → SurgicalCases.PatientID

---

## SurgicalCases

SurgicalCases is the central fact table.

Each surgical case links to:

- one patient
- one hospital
- one surgeon
- one procedure
- one robotic platform where applicable
- one outcome record

Relationship:
- SurgicalCases.CaseID → Outcomes.CaseID

---

## Outcomes

Each outcome record relates to one surgical case.

Relationship type:
- One-to-one between SurgicalCases and Outcomes

---

# Relationship Summary

| Parent Table | Primary Key | Child Table | Foreign Key | Relationship Type |
|---|---|---|---|---|
| Hospitals | HospitalID | Surgeons | HospitalID | One-to-Many |
| Hospitals | HospitalID | SurgicalCases | HospitalID | One-to-Many |
| Specialties | SpecialtyID | Procedures | SpecialtyID | One-to-Many |
| Specialties | SpecialtyID | Surgeons | SpecialtyID | One-to-Many |
| Procedures | ProcedureID | SurgicalCases | ProcedureID | One-to-Many |
| RoboticPlatforms | PlatformID | SurgicalCases | PlatformID | One-to-Many |
| Surgeons | SurgeonID | SurgicalCases | SurgeonID | One-to-Many |
| Surgeons | SurgeonID | TrainingGovernance | SurgeonID | One-to-Many |
| Patients | PatientID | SurgicalCases | PatientID | One-to-Many |
| SurgicalCases | CaseID | Outcomes | CaseID | One-to-One |

---

# Notes

The structure is designed to support SQL joins, audit reporting, governance monitoring, and Power BI dashboard development.

The relationship design keeps the project realistic while remaining manageable for a portfolio project.
