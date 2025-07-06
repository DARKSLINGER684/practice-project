/* create database and schemas 
script purpose: create database named 'datawarehouse' after checking if it already exists . additionaly , the script creates three schemas 
named bronze,silver and gold .
warning: running this script will drop entire database so use with caution and ensure you have proper backup before running this script.
*/

use master;
go
/-- drop and recreate the database 
if exists(select 1 from sys.databases where name ='datawarehouse')
begin
alter database datawarehouse set single_user with rollback immediate;
drop database datawarehouse;
end ;
go
create database datawarehouse;
go
use datawarehouse;
go
create schema bronze;
go
create schema silver;
go
create schema gold;
go

