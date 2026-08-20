# Analysis & Findings

## Overview

This analysis uses a synthetic robotic surgery dataset created for portfolio purposes. The hospital names are used only within the simulated dataset. The findings below do not represent the performance of the real hospitals or healthcare organisations named in the data.

The dataset contains 100 synthetic robotic-assisted surgical cases. SQL queries and Power BI reporting were used to examine surgical activity, outcomes, length of stay, readmissions, conversion to open surgery and governance review status.

## Key Findings

### Surgical Activity

The dataset contains 100 surgical cases across seven hospitals.

Mater Misericordiae and St Vincent's recorded the highest activity in the synthetic dataset, with 15 cases each. The remaining hospitals recorded 14 cases each.

### Complications

The overall complication rate in the dataset was 7%.

Complication rates are useful as an audit indicator, but differences should not be interpreted in isolation. Factors such as procedure type, patient complexity, case volume and the small synthetic sample size would need to be considered before drawing conclusions about performance.

### Conversion to Open Surgery

The overall conversion-to-open surgery rate was 6%.

Conversion rate can be monitored as part of robotic surgery audit reporting. Individual cases or differences between hospitals would require further review and clinical context rather than being treated automatically as poor performance.

### 30-Day Readmissions

The overall 30-day readmission rate was 14%.

Readmission is a useful outcome measure for monitoring, but further analysis would be required to understand the reasons for readmission and whether they were related to the surgical procedure.

### Length of Stay

Robotic Hernia Repair and Robotic Lobectomy had the highest average length of stay in the synthetic dataset, at approximately 4.31 days.

Differences in length of stay may help identify areas for further investigation, but procedure type and patient characteristics should be considered before making comparisons.

### Governance Review

Twenty-eight of the 100 synthetic records indicated that governance review had not been completed. In this dataset, these records were concentrated in University Hospital Galway and University Hospital Limerick.

This would represent a clear governance exception for follow-up in a real audit environment. It would require validation of the underlying records and escalation through the appropriate governance process rather than an assumption that the hospitals themselves were performing poorly.

## Data Quality and Interpretation

Data quality checks were added before interpreting the KPI results. These checks look for issues including duplicate patient records, missing key information, implausible values, missing or duplicate outcome records, inconsistent complication information and incomplete governance records.

The analysis demonstrates how SQL and Power BI can be used together to support audit reporting, identify exceptions and highlight areas requiring further investigation.

Because the dataset is synthetic, the findings are intended to demonstrate analytical and reporting skills only and should not be interpreted as real clinical findings.
