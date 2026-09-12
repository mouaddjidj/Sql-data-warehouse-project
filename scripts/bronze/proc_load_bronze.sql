/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE or ALTER PROCEDURE bronze.load_bronze AS
	BEGIN
	   DECLARE @start_time DATETIME,@end_time DATETIME;
	   BEGIN TRY
	PRINT'=======================================================';
	PRINT'LOADING BRONZE LAYER';
	PRINT'=======================================================';

	PRINT'-------------------------------------------------------';
	PRINT'LOADING CRM TABLES';
	PRINT'-------------------------------------------------------';

	-- CRM CUSTOMER INFO
	SET @start_time = GETDATE();
	PRINT'>>Truncating Table:bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;

	PRINT'>>Inserting Data Into:bronze.crm_cust_info';
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\pc cam\OneDrive\Bureau\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT'LOADING DURATION:'+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';


	-- CRM PRODUCT INFO
	SET @start_time = GETDATE();

	PRINT'>>Truncating Table:bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;

	PRINT'>>Inserting Data Into:bronze.crm_prd_info';
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\pc cam\OneDrive\Bureau\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT'LOADING DURATION:'+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';


	-- CRM SALES DETAILS
	SET @start_time = GETDATE();

	PRINT'>>Truncating Table:bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details;

	PRINT'>>Inserting Data Into:bronze.crm_sales_details';
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\pc cam\OneDrive\Bureau\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT'LOADING DURATION:'+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';


	PRINT'*******************************************************';
	PRINT'LOADING ERP TABLES';
	PRINT'*******************************************************';


	-- ERP CUSTOMER AZ12
	SET @start_time = GETDATE();

	PRINT'>>Truncating Table:bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;

	PRINT'>>Inserting Data Into:bronze.erp_cust_az12';
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\pc cam\OneDrive\Bureau\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT'LOADING DURATION:'+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';


	-- ERP LOCATION A101
	SET @start_time = GETDATE();

	PRINT'>>Truncating Table:bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;

	PRINT'>>Inserting Data Into:bronze.erp_loc_a101';
	BULK INSERT bronze.erp_loc_a101
	FROM 'C:\Users\pc cam\OneDrive\Bureau\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT'LOADING DURATION:'+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';


	-- ERP PRODUCT CATEGORY
	SET @start_time = GETDATE();

	PRINT'>>Truncating Table:bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;

	PRINT'>>Inserting Data Into:bronze.erp_px_cat_g1v2';
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\pc cam\OneDrive\Bureau\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT'LOADING DURATION:'+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';

END TRY
	  BEGIN CATCH
	        PRINT'====================================';
			PRINT'ERROR OCCURED DURING DATA LOADING';
			PRINT'error message'+ERROR_MESSAGE();
			PRINT'error message'+CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT'===================================='
	  END CATCH
	END
