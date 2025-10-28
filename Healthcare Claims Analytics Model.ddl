
CREATE TABLE IF NOT EXISTS Dim_Date
(
	date_key INTEGER COMMENT 'Surrogate PK, formatted as YYYYMMDD' NOT NULL ,
	full_date DATE COMMENT 'Calendar date' NULL ,
	day_of_month INTEGER COMMENT 'Day number (1–31)' NULL ,
	day_name VARCHAR(20) COMMENT 'Name of day (e.g., Monday)' NULL ,
	week_of_year INTEGER COMMENT 'Week number (1–52)' NULL ,
	month_number INTEGER COMMENT 'Month number (1–12)' NULL ,
	month_name VARCHAR(20) COMMENT 'Month name' NULL ,
	quarter_number INTEGER COMMENT 'Quarter (1–4)' NULL ,
	quarter_name VARCHAR(20) COMMENT 'e.g., “Q1”, “Q2”' NULL ,
	year_number INTEGER COMMENT 'Year value' NULL ,
	is_weekend CHAR(1) COMMENT 'Weekend indicator (Y/N)' NULL ,
	is_holiday CHAR(1) COMMENT 'Holiday indicator (Y/N)' NULL 
);

CREATE UNIQUE INDEX  XPKDim_Date ON  Dim_Date
(
	date_key ASC
);

CREATE TABLE IF NOT EXISTS Dim_Diagnosis
(
	diagnosis_key INTEGER COMMENT 'Surrogate PK for diagnosis dimension' NOT NULL ,
	diagnosis_code VARCHAR(20) COMMENT 'ICD-10 or diagnosis code' NULL ,
	diagnosis_description VARCHAR(500) COMMENT 'Text description of diagnosis' NULL ,
	diagnosis_category VARCHAR(100) COMMENT 'Group or category' NULL ,
	is_primary_diagnosis CHAR(1) COMMENT 'Indicates main diagnosis (Y/N)' NULL ,
	created_date DATE COMMENT 'Record creation timestamp' NULL ,
	updated_date DATE COMMENT 'Record update timestamp' NULL 
);

CREATE UNIQUE INDEX  XPKDim_Diagnosis ON  Dim_Diagnosis
(
	diagnosis_key ASC
);

CREATE TABLE IF NOT EXISTS Dim_Location
(
	location_key INTEGER COMMENT 'Surrogate PK for location dimension' NOT NULL ,
	facility_id VARCHAR(50) COMMENT 'Source facility ID' NULL ,
	facility_name VARCHAR(200) COMMENT 'Facility or clinic name' NULL ,
	address_line1 VARCHAR(200) COMMENT 'Street address' NULL ,
	address_line2 VARCHAR(200) COMMENT 'Suite or unit' NULL ,
	city VARCHAR(100) COMMENT 'City name' NULL ,
	state CHAR(2) COMMENT 'State abbreviation' NULL ,
	zip_code VARCHAR(10) COMMENT 'ZIP code' NULL ,
	county VARCHAR(100) COMMENT 'County name' NULL ,
	created_date DATE COMMENT 'Record creation timestamp' NULL ,
	updated_date DATE COMMENT 'Record update timestamp' NULL 
);

CREATE UNIQUE INDEX  XPKDim_Location ON  Dim_Location
(
	location_key ASC
);

CREATE TABLE IF NOT EXISTS Dim_Patient
(
	patient_key INT COMMENT 'Surrogate key for patient dimension
' NOT NULL ,
	patient_id VARCHAR(50) COMMENT 'Member ID from source system' NULL ,
	first_name VARCHAR(100) COMMENT 'Patient’s first name' NULL ,
	last_name VARCHAR(100) COMMENT 'Patient’s last name' NULL ,
	full_name VARCHAR(100) COMMENT 'Derived concatenation of first + last' NULL ,
	date_of_birth DATE COMMENT 'Patient date of birth' NULL ,
	gender CHAR(1) COMMENT 'Gender indicator (M/F/O)' NULL ,
	address_line1 VARCHAR(200) COMMENT 'Street address' NULL ,
	address_line2 VARCHAR(200) COMMENT 'Apartment or suite number' NULL ,
	city VARCHAR(100) COMMENT 'City name' NULL ,
	state CHAR(2) COMMENT 'State abbreviation' NULL ,
	zip_code VARCHAR(10) COMMENT 'ZIP or postal code' NULL ,
	created_date DATE COMMENT 'Record creation date' NULL ,
	updated_date DATE COMMENT 'Record update date' NULL ,
	is_active CHAR(1) COMMENT 'Active/inactive status flag' NULL 
);

CREATE UNIQUE INDEX  XPKDim_Patient ON  Dim_Patient
(
	patient_key ASC
);

CREATE TABLE IF NOT EXISTS Dim_Provider
(
	provider_key INTEGER COMMENT 'Surrogate PK for provider dimension' NOT NULL ,
	provider_npi VARCHAR(20) COMMENT 'National Provider Identifier' NULL ,
	provider_name VARCHAR(200) COMMENT 'Provider or facility name' NULL ,
	provider_type VARCHAR(100) COMMENT 'Specialty or provider type' NULL ,
	tax_id VARCHAR(20) COMMENT 'Business tax identifier' NULL ,
	phone_number VARCHAR(20) COMMENT 'Contact phone' NULL ,
	address_line1 VARCHAR(200) COMMENT 'Street addres' NULL ,
	address_line2 VARCHAR(200) COMMENT 'Suite or unit' NULL ,
	city VARCHAR(100) COMMENT 'City' NULL ,
	state CHAR(2) COMMENT 'State abbreviation' NULL ,
	zip_code VARCHAR(10) COMMENT 'ZIP code' NULL ,
	network_flag CHAR(1) COMMENT 'In-network (Y/N)' NULL ,
	created_date DATE COMMENT 'Record creation date' NULL ,
	updated_date DATE COMMENT 'Record update date' NULL 
);

CREATE UNIQUE INDEX  XPKDim_Provider ON  Dim_Provider
(
	provider_key ASC
);

CREATE TABLE IF NOT EXISTS Fact_Claims
(
	claim_line_id INTEGER COMMENT 'Unique claim line identifier (PK)' NOT NULL ,
	claim_id VARCHAR(50) COMMENT 'Claim header ID (PHI when linked to patient)' NULL ,
	line_number INTEGER COMMENT 'Line within claim' NULL ,
	patient_key INT COMMENT 'FK to Dim_Patient' NOT NULL ,
	provider_key INTEGER COMMENT 'FK to Dim_Provider' NOT NULL ,
	diagnosis_key INTEGER COMMENT 'FK to Dim_Diagnosis' NOT NULL ,
	location_key INTEGER COMMENT 'FK to Dim_Location' NOT NULL ,
	procedure_code VARCHAR(20) COMMENT 'CPT/HCPCS code' NULL ,
	procedure_description VARCHAR(20) COMMENT 'Text description' NULL ,
	billed_amount DECIMAL(12,2) COMMENT 'Amount billed' NULL ,
	allowed_amount DECIMAL(12,2) COMMENT 'Amount allowed' NULL ,
	paid_amount DECIMAL(12,2) COMMENT 'Amount paid' NULL ,
	patient_responsibility_amount DECIMAL(12,2) COMMENT 'Copay/deductible' NULL ,
	claim_status VARCHAR(50) COMMENT 'Paid / Denied / Pending' NULL ,
	created_date DATE COMMENT 'Record creation timestamp' NULL ,
	updated_date DATE COMMENT 'Record update timestamp' NULL ,
	Service_date_key INTEGER COMMENT 'Surrogate PK, formatted as YYYYMMDD' NOT NULL ,
	paid_date_key INTEGER COMMENT 'Surrogate PK, formatted as YYYYMMDD' NOT NULL 
);

CREATE UNIQUE INDEX  XPKFact_Claims ON  Fact_Claims
(
	claim_line_id ASC
);

CREATE INDEX  XIF1Fact_Claims ON  Fact_Claims
(
	patient_key ASC
);

CREATE INDEX  XIF2Fact_Claims ON  Fact_Claims
(
	provider_key ASC
);

CREATE INDEX  XIF3Fact_Claims ON  Fact_Claims
(
	diagnosis_key ASC
);

CREATE INDEX  XIF4Fact_Claims ON  Fact_Claims
(
	location_key ASC
);

CREATE INDEX  XIF5Fact_Claims ON  Fact_Claims
(
	Service_date_key ASC
);

CREATE INDEX  XIF6Fact_Claims ON  Fact_Claims
(
	paid_date_key ASC
);
