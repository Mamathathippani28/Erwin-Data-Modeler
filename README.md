# README – Healthcare Claims Analytics Data Model (Erwin)

## 📘 Overview
This project demonstrates a complete **data modeling workflow using Erwin Data Modeler**, focused on designing a **Healthcare Claims Analytics Data Mart**. The purpose is to showcase the ability to design dimensional models, manage relationships, automate DDL generation, and handle metadata governance — even without prior Erwin experience.

The data model is based on a **Star Schema**, supporting claim-level analytics, provider performance insights, and compliance tracking for PII/PHI data.

## 🎯 Objective

To build a star schema in **Erwin Data Modeler** that integrates patients, providers, diagnoses, locations, and claim transaction data, and forward-engineer the design into a physical database (MySQL target).

This project highlights transferable skills in **data modeling**, **SQL optimization**, **DDL automation**, and **metadata tagging** aligned with real-world enterprise healthcare systems.


## 🏗️ Model Design Summary
### Entities
- **Fact_Claims** – Central fact table holding claim metrics and foreign keys.
- **Dim_Patient** – Patient demographics with PII tagging for HIPAA compliance.
- **Dim_Provider** – Provider and specialty information.
- **Dim_Diagnosis** – ICD-10 diagnosis details.
- **Dim_Location** – Facility and service location data.
- **Dim_Date** – Calendar dimension used twice (service date, payment date).

### Relationships
| Parent | Child | Foreign Key | Type | Cardinality |
|--------|--------|--------------|------|--------------|
| Dim_Patient | Fact_Claims | patient_key | Non-identifying | 1→Many |
| Dim_Provider | Fact_Claims | provider_key | Non-identifying | 1→Many |
| Dim_Diagnosis | Fact_Claims | diagnosis_key | Non-identifying | 1→Many |
| Dim_Location | Fact_Claims | location_key | Non-identifying | 1→Many |
| Dim_Date | Fact_Claims | service_date_key / paid_date_key | Role-playing | 1→Many |


## ⚙️ Tools & Workflow

- **Tool Used:** Erwin Data Modeler (Academic License)
- **Database Target:** MySQL 8.x
- **Process:**
  1. Logical Model → Physical Model → Forward Engineering
  2. Defined attributes, data types, and relationships.
  3. Generated `.DDL` schema with PK/FK constraints and comments.
  4. Validated model integrity and role-playing dimensions.


## 📄 Outputs
- **Erwin Logical and Physical Models (.erwin file)**
- **Auto-generated MySQL DDL (.sql)**
- **ER Diagram Screenshot (Star Schema Visualization)**
- **One-Page Technical Summary (PDF)**

---

## 🧩 Visual Representation
```
          +----------------+
          |  Dim_Patient   |
          +----------------+
                 | 1
                 |∞
          +----------------+
          |  Fact_Claims   |
          +----------------+
           /   |   |   |   \
          ∞    ∞   ∞   ∞    ∞
  +--------+ +--------+ +--------+ +--------+
  |Dim_Prov| |Dim_Diag| |Dim_Loc | |Dim_Date|
  +--------+ +--------+ +--------+ +--------+
                  (Service_Date / Paid_Date)
```

## 🚀 Next Steps
- Populate tables using mock or CSV-based data.
- Implement ETL to load and transform data (e.g., PySpark, Glue, or ADF).
- Validate schema by running BI queries on Fact_Claims joins.
- Extend metadata tagging and data lineage for governance.

## 👩‍💻 Author
**Mamatha Thippani**  
Data Engineer | Cloud & ETL Developer  
**Tool:** Erwin Data Modeler | **Database:** MySQL 8.x  
**Date:** October 2025

