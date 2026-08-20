# 🤖 Robotic Surgery Audit Analytics

Healthcare audit and analytics portfolio project focused on robotic-assisted surgery governance, operational reporting, and clinical performance monitoring.

---

## 📌 Project Overview

This project simulates a healthcare governance and robotic surgery audit reporting environment designed to support operational oversight, performance monitoring, and data-driven decision-making.

The project is inspired by real-world healthcare analytics and clinical audit environments, including surgical performance monitoring, hospital reporting, and governance frameworks used within modern healthcare systems.

---

## 📊 Dashboard Screenshots

### Executive Overview Dashboard
![Executive Dashboard](images/executive_dashboard.png)

### Clinical & Governance Analysis Dashboard
![Clinical Dashboard](images/clinical_outcomes_dashboard.png)

---

## 🎯 Project Objectives

- Design a relational SQL database for robotic surgery audit data
- Create realistic synthetic healthcare datasets
- Analyse surgical activity and outcomes
- Develop operational and governance-focused KPIs
- Build dashboards and reporting outputs using Power BI
- Demonstrate practical skills in SQL, data analysis, reporting, and healthcare operations

---

## ✅ Key Dashboard Features

- 📈 Executive KPI reporting
- ⚠️ Complication rate monitoring
- 🏥 Readmission analysis
- 🔄 Conversion-to-open surgery tracking
- ⏱️ Length of stay analysis
- 📊 Hospital performance comparison
- 📅 Surgical activity trend reporting
- 🎛️ Interactive Power BI filtering and slicing
  
---

## 🗂️ Project Components

### Database Design
- Hospitals
- Surgical Procedures
- Surgeons
- Patient Cases
- Outcomes
- Governance & Training Records

### Data Quality Checks
Before carrying out KPI analysis and dashboard reporting, the dataset was checked for common data quality issues to make sure the information being analysed was complete, consistent and suitable for reporting.

SQL checks were created to identify:
- Duplicate patient records
- Missing key patient information
- Implausible patient and surgical case values
- Missing or duplicate outcome records
- Inconsistent complication information
- Surgeons without governance records
- Incomplete training and governance requirements

The data quality checks are contained in [`sql/11_data_quality_checks.sql`](sql/11_data_quality_checks.sql).

### Reporting & Analytics
- Surgical volume reporting
- Complication tracking
- Length of stay analysis
- Hospital performance comparisons
- Governance KPI dashboards

---

## 🛠️ Tools Used

- SQL Server
- Power BI
- Excel

---

## 💡 Skills Demonstrated

- SQL database design
- Data quality validation
- Healthcare data modelling
- Power BI dashboard development
- DAX measure creation
- KPI reporting
- Data visualisation
- Operational analytics
- Governance reporting
- Synthetic healthcare dataset generation

---

## 📁 Repository Structure

| Folder | Purpose |
|---|---|
| documentation | Project planning and design documents |
| sql | Database creation scripts and SQL queries |
| data | Synthetic datasets and exports |
| dashboards | Power BI dashboards and reporting |
| images | Screenshots, diagrams, and visual assets |

---

## Project Summary

Core SQL database development, synthetic healthcare audit dataset generation, and multi-page Power BI dashboard reporting have been completed.

The project demonstrates healthcare governance analytics, KPI reporting, operational monitoring, and clinical audit-focused dashboard design within a simulated robotic surgery reporting environment.
