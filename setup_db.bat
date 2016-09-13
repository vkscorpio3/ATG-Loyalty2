@echo off
setlocal

rem ------------------------------------------------------------
rem   Commerce v.3.0 (COM) SQL Setup
rem
rem Script Version 1.0 (16 April 2006) by K Layher
rem
rem If this is the first time this script is run, then 
rem backup the existing Solid Database directory.
rem Otherwise, offer to restore Solid before proceeding.
rem Then, create and populate the SQL tables needed for 
rem the class exercises.


if not "%ATGDIR%" == "" (
 set DYNAMO_HOME=%ATGDIR%\home
) else if not "%DYNAMO_HOME%" == "" (
 set ATGDIR=%DYNAMO_HOME%\..
) 

if "%ATGDIR%" == "" (
  echo. 
  echo. ERROR: You must set the ATGDIR variable to point to the
  echo. your ATG installation 
  echo. ^(for instance, set ATGDIR=C:\ATG\ATG2007.1^)
  echo.
  goto :end
)


set logfile=com-setup-sql.log
set SOLIDDIR=%DYNAMO_HOME%\..\DAS\solid
set SOLIDPATH=%SOLIDDIR%\i486-unknown-win32
set COMSOLID=%SOLIDDIR%\atgdb_com

REM Creating COM solid database

echo Copying DAS\solid\atgdb to DAS\solid\atgdb_com directory
if exist %COMSOLID% (
  echo. %COMSOLID% already exists, copying to -save
  xcopy %COMSOLID% %COMSOLID%-save /s /e /k /q /y /i
  rmdir %COMSOLID% /s /q
)
mkdir %COMSOLID%
xcopy %SOLIDDIR%\atgdb %COMSOLID% /E /V /F /Q /-Y

echo Starting COM Solid database now.  Please press any key when Solid startup completes...
start %SOLIDPATH%\solfe.exe -c %COMSOLID%
pause

rem If the log file already exists, then just delete it
echo. logfile = %logfile%
if exist %logfile% del %logfile%

rem Create the required tables, in all DB Schemas
rem If the table creation scripts don't exist, issue an error
 
rem echo.
rem echo. I will now create and populate the database tables required for this lab

rem Create new user for b2c and b2b tables

echo. Creating new db users called b2c and b2b

  %solidPath%\solsql -f COM_user_setup.sql "tcp localhost 1313" admin admin >> %logfile%

rem Create B2C Tables
echo. Beginning Table Creation
if exist COM_b2c_ddl.sql (
  echo. Creating the Commerce B2C SQL on b2c
  %solidPath%\solsql -f %ATGDIR%\DAS\sql\install\solid\das_ddl.sql "tcp localhost 1313" b2c b2c >> %logfile%
  %solidPath%\solsql -f %ATGDIR%\DPS\sql\install\solid\dps_ddl.sql "tcp localhost 1313" b2c b2c >> %logfile%
  %solidPath%\solsql -f %ATGDIR%\DSS\sql\install\solid\dss_ddl.sql "tcp localhost 1313" b2c b2c >> %logfile%
  %solidPath%\solsql -f %ATGDIR%\DCS\sql\install\solid\dcs_ddl.sql "tcp localhost 1313" b2c b2c >> %logfile%
  %solidPath%\solsql -f COM_b2c_ddl.sql "tcp localhost 1313" b2c b2c >> %logfile%
  %solidPath%\solsql -f %ATGDIR%\Loyalty\sql\loyalty.sql "tcp localhost 1313" b2c b2c >> %logfile%
  %solidPath%\solsql -f %ATGDIR%\Loyalty2\sql\loyalty2.sql "tcp localhost 1313" b2c b2c >> %logfile%
) else (
  echo. The file COM_b2c_ddl.sql could not be located.
)

rem Create B2B Tables
if exist COM_b2b_ddl.sql (
  echo. Creating the Commerce B2B SQL on b2b
  %solidPath%\solsql -f %ATGDIR%\DAS\sql\install\solid\das_ddl.sql "tcp localhost 1313" b2b b2b >> %logfile%
  %solidPath%\solsql -f %ATGDIR%\DPS\sql\install\solid\dps_ddl.sql "tcp localhost 1313" b2b b2b >> %logfile%
  %solidPath%\solsql -f %ATGDIR%\DSS\sql\install\solid\dss_ddl.sql "tcp localhost 1313" b2b b2b >> %logfile%
  %solidPath%\solsql -f %ATGDIR%\DCS\sql\install\solid\dcs_ddl.sql "tcp localhost 1313" b2b b2b >> %logfile%
  %solidPath%\solsql -f %ATGDIR%\B2BCommerce\sql\install\solid\b2bcommerce_ddl.sql "tcp localhost 1313" b2b b2b >> %logfile%
  %solidPath%\solsql -f COM_b2b_ddl.sql "tcp localhost 1313" b2b b2b >> %logfile%
  %solidPath%\solsql -f %ATGDIR%\Loyalty\sql\loyalty.sql "tcp localhost 1313" b2b b2b >> %logfile%
  %solidPath%\solsql -f %ATGDIR%\Loyalty2\sql\loyalty2.sql "tcp localhost 1313" b2b b2b >> %logfile%
) else (
  echo. The file COM_b2b_ddl.sql could not be located.
)
  
  

rem Populate the Dynamusic tables
echo Populating the Dynamusic tables
cd %DYNAMO_HOME%

call %DYNAMO_HOME%\bin\startSQLRepository -m DynamusicB2C -import %ATGDIR%\DynamusicB2C\config\dynamusic\DynamusicB2CData.xml -repository /atg/commerce/catalog/ProductCatalog

call %DYNAMO_HOME%\bin\startSQLRepository -m DynamusicB2C -import %ATGDIR%\DynamusicB2C\config\dynamusic\events-data.xml -repository /dynamusic/EventsRepository

call %DYNAMO_HOME%\bin\startSQLRepository -m DynamusicB2C -import %ATGDIR%\DynamusicB2C\config\dynamusic\DynamusicB2CInventoryData.xml -repository /atg/commerce/inventory/InventoryRepository


call %DYNAMO_HOME%\bin\startSQLRepository -m DynamusicB2B -import %ATGDIR%\DynamusicB2B\config\dynamusic\DynamusicB2BData.xml -repository /atg/commerce/catalog/ProductCatalog

call %DYNAMO_HOME%\bin\startSQLRepository -m DynamusicB2B -import %ATGDIR%\DynamusicB2B\config\dynamusic\events-data.xml -repository /dynamusic/EventsRepository

call %DYNAMO_HOME%\bin\startSQLRepository -m DynamusicB2B -import %ATGDIR%\DynamusicB2B\config\dynamusic\DynamusicB2BInventoryData.xml -repository /atg/commerce/inventory/InventoryRepository

call %DYNAMO_HOME%\bin\startSQLRepository -m DynamusicB2B -import %ATGDIR%\DynamusicB2B\config\dynamusic\DynamusicB2BUserData.xml -repository /atg/userprofiling/ProfileAdapterRepository


call %DYNAMO_HOME%\bin\startSQLRepository -m Loyalty -repository /loyalty/LoyaltyRepository

goto :endofscript

:pauseexit
pause

:endofscript
echo.
echo. Database initialized.
echo. See %logfile% for details
echo. you can restart this database at any time using the following command:
echo. %SOLIDPATH%\solfe.exe -c %COMSOLID%
:end

	echo.
	echo. script exit
	echo.


endlocal