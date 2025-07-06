/* creating procedure to load data into bronze layer using bulk insert . 
use EXEC bronze.load_bronze*/


-- creating stored procedures to load data into bronze  
CREATE OR ALTER PROCEDURE bronze.load_bronze as 
begin
	declare @start_time datetime, @end_time datetime,@batch_start_time datetime,@batch_end_time datetime;
	set @batch_start_time =GETDATE();
	begin try 
		print '==========================================================';
		print 'loading bronze layer';
		print '==========================================================';
		print '----------------------------------------------------------';
		print 'loading crm tables';
		print '----------------------------------------------------------';
		-- bulk loading from crm source
		set @start_time=GETDATE();
		truncate table bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		from 'C:\Users\user\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		set @end_time=GETDATE();
		print '>> load duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds'
		print'---------------------------------------------------'

		set @start_time=GETDATE();
		truncate table bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		from 'C:\Users\user\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		set @end_time=GETDATE();
		print '>> load duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds'
		print'---------------------------------------------------'


		set @start_time=GETDATE();
		truncate table bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		from 'C:\Users\user\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		set @end_time=GETDATE();
		print '>> load duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds'
		print'---------------------------------------------------'


		print '----------------------------------------------------------';
		print 'loading erp tables';
		print '----------------------------------------------------------';
		-- bulk loading from erp source 
		set @start_time=GETDATE();
		truncate table bronze.erp_cust_AZ12;
		BULK INSERT bronze.erp_cust_AZ12
		from 'C:\Users\user\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		set @end_time=GETDATE();
		print '>> load duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds'
		print'---------------------------------------------------'

		set @start_time=GETDATE();
		truncate table bronze.erp_LOC_A101;
		BULK INSERT bronze.erp_LOC_A101
		from 'C:\Users\user\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		set @end_time=GETDATE();
		print '>> load duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds'
		print'---------------------------------------------------'

		set @start_time=GETDATE();
		truncate table bronze.erp_PX_CAT_G1V2;
		BULK INSERT bronze.erp_PX_CAT_G1V2
		from 'C:\Users\user\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		set @end_time=GETDATE();
		print '>> load duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds'
		print'---------------------------------------------------'
	end try
	begin catch
		print'==========================================================================='
		print'error occured during loading bronze layer';
		print'error message'+cast(error_message() as nvarchar);
		print'error message'+cast(error_number()as nvarchar);
		print'==========================================================================='
	end catch
	set @batch_end_time=GETDATE();
	print'load duration of bronze layer:'+cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar)+'seconds'
end 
