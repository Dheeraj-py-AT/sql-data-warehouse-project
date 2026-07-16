/*
=============================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=============================================================

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncate the bronze tables before loading data.
    - Uses the 'COPY' command to load data from CSV files to bronze tables.

Parameters:
    None,
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    CALL bronze.load_bronze();
=============================================================
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
	start_time TIMESTAMP;
	end_time TIMESTAMP;
	duration INTERVAL;
BEGIN
	start_time := CURRENT_TIMESTAMP;
	RAISE NOTICE 'Loading Bronze Layer';
	RAISE NOTICE 'Start Time: %', start_time;
	
	TRUNCATE TABLE bronze.crm_cust_info;
	COPY bronze.crm_cust_info
	FROM 'D:/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
	WITH (
		FORMAT CSV,
		HEADER TRUE,
		DELIMITER ','
	);
	
	TRUNCATE TABLE bronze.crm_prd_info;
	COPY bronze.crm_prd_info
	FROM 'D:/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
	WITH (
		FORMAT CSV,
		HEADER TRUE,
		DELIMITER ','
	);
	
	TRUNCATE TABLE bronze.crm_sales_details;
	COPY bronze.crm_sales_details
	FROM 'D:/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
	WITH (
		FORMAT CSV,
		HEADER TRUE,
		DELIMITER ','
	);
	
	TRUNCATE TABLE bronze.erp_cust_az12;
	COPY bronze.erp_cust_az12
	FROM 'D:/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv'
	WITH (
		FORMAT CSV,
		HEADER TRUE,
		DELIMITER ','
	);
	
	TRUNCATE TABLE bronze.erp_loc_a101;
	COPY bronze.erp_loc_a101
	FROM 'D:/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv'
	WITH (
		FORMAT CSV,
		HEADER TRUE,
		DELIMITER ','
	);
	
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	COPY bronze.erp_px_cat_g1v2
	FROM 'D:/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv'
	WITH (
		FORMAT CSV,
		HEADER TRUE,
		DELIMITER ','
	);
	
	end_time := CURRENT_TIMESTAMP;
	duration := end_time - start_time;
	RAISE NOTICE 'Loading Bronze layer is completed';
	RAISE NOTICE 'End Time: %', end_time;
	RAISE NOTICE 'Total Duration: %', duration;
END;
$$;
