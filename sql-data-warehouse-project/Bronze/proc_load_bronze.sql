-- USE: exec bronze.load_bronze;

create or alter procedure bronze.load_bronze as 
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime ;
	begin try
		set @batch_start_time = GETDATE();
		print'=======================================================';
		print'Loading Bronze Layer';
		print'=======================================================';

		print'-------------------------------------------------------';
		print'Loading CRM Table';
		print'-------------------------------------------------------';
		set @start_time = GETDATE();
		truncate table bronze.crm_cust_info;

		bulk insert bronze.crm_cust_info
		from 'D:\Desktop\Portfolio\BaraaWarehouse\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print 'loading duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'second';
		print '-----------------';
		set @start_time = GETDATE();
		truncate table bronze.crm_prd_info;

		bulk insert bronze.crm_prd_info
		from 'D:\Desktop\Portfolio\BaraaWarehouse\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print 'loading duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'second';
		print '-----------------';
		set @start_time = GETDATE();
		truncate table bronze.crm_sales_details;

		bulk insert bronze.crm_sales_details
		from 'D:\Desktop\Portfolio\BaraaWarehouse\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print 'loading duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'second';

		print'-------------------------------------------------------';
		print'Loading CRM Table';
		print'-------------------------------------------------------';

		set @start_time = GETDATE();

		truncate table bronze.erp_cust_az12;

		bulk insert bronze.erp_cust_az12
		from 'D:\Desktop\Portfolio\BaraaWarehouse\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);

		set @end_time = GETDATE();
		print 'loading duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'second';
		print '-----------------';
		set @start_time = GETDATE();

		truncate table bronze.erp_loc_a101;

		bulk insert bronze.erp_loc_a101
		from 'D:\Desktop\Portfolio\BaraaWarehouse\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);

		set @end_time = GETDATE();
		print 'loading duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'second';
		print '-----------------';
		set @start_time = GETDATE();

		truncate table bronze.erp_px_cat_g1v2;

		bulk insert bronze.erp_px_cat_g1v2
		from 'D:\Desktop\Portfolio\BaraaWarehouse\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);

		set @end_time = GETDATE();
		print 'loading duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'second';
		print '-----------------';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='

	end try
	begin catch
		print '===================================================================';
		print 'error occured during loading bronze layer';
		print 'error message' + error_message();
		print 'error message' + cast(error_number() as nvarchar);
		print 'error message' + cast(error_state() as nvarchar);
		print '===================================================================';
	end catch
end
