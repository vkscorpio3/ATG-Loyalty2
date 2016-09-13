@echo off
setlocal

REM ---------------------------------------------------
REM
REM Usage:
REM    first, be sure Solid is NOT running
REM
REM    Then, open a cmd window and enter the following commands:
REM    set ATGDIR=atg installation location
REM	(e.g. set ATGDIR=C:\ATG\ATG2007.1)
REM    cd C:\ATG\Training\Commerce\setup
REM    setup_COM
REM
REM ---------------------------------------------------

echo -- starting setup_COM

REM check if ATGDIR is set.  If not, check for older
REM use variable DYNAMO_HOME.
if not "%ATGDIR%" == "" (
 set DYNAMO_HOME=%ATGDIR%\home
) else if not "%DYNAMO_HOME%" == "" (
 set ATGDIR=%DYNAMO_HOME%\..
) 

if "%DYNAMO_HOME%" == "" (
  echo. 
  echo. You must set the ATGDIR variable to point to the
  echo. your ATG installation 
  echo. ^(for instance, set ATGDIR=C:\ATG\ATG2007.1^)
  echo.
  goto :end
)
echo -- using ATGDIR= %ATGDIR%

set SAVESUFFIX=com-save

rem Next lines provide fixed files for Motorprise and PioneerCycling
xcopy scheduled_order_preview.jsp %DYNAMO_HOME%\..\MotorpriseJSP\j2ee-apps\motorprise\web-app\en\user /Q /Y
xcopy cart.jsp %DYNAMO_HOME%\..\PioneerCyclingJSP\j2ee-apps\pioneer\web-app\en\checkout /Q /Y

REM ---------------------------------------------------
REM Copy FOLDERS DynamusicB2C and DynamusicB2B
REM ---------------------------------------------------


echo. Copying DynamusicB2B directory
mkdir %DYNAMO_HOME%\..\DynamusicB2B-save
if exist %DYNAMO_HOME%\..\DynamusicB2B (
  xcopy %DYNAMO_HOME%\..\DynamusicB2B %DYNAMO_HOME%\..\DynamusicB2B-save /s /e /k /q /y /i
  rmdir %DYNAMO_HOME%\..\DynamusicB2B /s /q
)

mkdir %DYNAMO_HOME%\..\DynamusicB2B
xcopy DynamusicB2B %DYNAMO_HOME%\..\DynamusicB2B /E /V /F /Q /-Y

echo. Copying DynamusicB2C directory
mkdir %DYNAMO_HOME%\..\DynamusicB2C-save
if exist %DYNAMO_HOME%\..\DynamusicB2C (
  xcopy %DYNAMO_HOME%\..\DynamusicB2C %DYNAMO_HOME%\..\DynamusicB2C-save /s /e /k /q /y /i
  rmdir %DYNAMO_HOME%\..\DynamusicB2C /s /q
)

mkdir %DYNAMO_HOME%\..\DynamusicB2C
xcopy DynamusicB2C %DYNAMO_HOME%\..\DynamusicB2C /E /V /F /Q /-Y

echo. Copying Loyalty directory
mkdir %DYNAMO_HOME%\..\Loyalty-save
if exist %DYNAMO_HOME%\..\Loyalty (
  xcopy %DYNAMO_HOME%\..\Loyalty %DYNAMO_HOME%\..\Loyalty-save /s /e /k /q /y /i
  rmdir %DYNAMO_HOME%\..\Loyalty /s /q
)

mkdir %DYNAMO_HOME%\..\Loyalty
xcopy Loyalty %DYNAMO_HOME%\..\Loyalty /E /V /F /Q /-Y

echo. Copying Loyalty2 directory
mkdir %DYNAMO_HOME%\..\Loyalty2-save
if exist %DYNAMO_HOME%\..\Loyalty2 (
  xcopy %DYNAMO_HOME%\..\Loyalty2 %DYNAMO_HOME%\..\Loyalty2-save /s /e /k /q /y /i
  rmdir %DYNAMO_HOME%\..\Loyalty2 /s /q
)

mkdir %DYNAMO_HOME%\..\Loyalty2
xcopy Loyalty2 %DYNAMO_HOME%\..\Loyalty2 /E /V /F /Q /-Y

echo. Copying LoyaltyFulfillment directory
mkdir %DYNAMO_HOME%\..\LoyaltyFulfillment-save
if exist %DYNAMO_HOME%\..\LoyaltyFulfillment (
  xcopy %DYNAMO_HOME%\..\LoyaltyFulfillment %DYNAMO_HOME%\..\LoyaltyFulfillment-save /s /e /k /q /y /i
  rmdir %DYNAMO_HOME%\..\LoyaltyFulfillment /s /q
)

mkdir %DYNAMO_HOME%\..\LoyaltyFulfillment
xcopy LoyaltyFulfillment %DYNAMO_HOME%\..\LoyaltyFulfillment /E /V /F /Q /-Y



REM ---------------------------------------------------
REM DATABASE SETUP uses StartSQLRepository...
REM ... and FakeXADataSource components
REM ---------------------------------------------------

rem delegate DB setup
call setup_db



REM ---------------------------------------------------
REM Copy an UPDATED JTDataSource into
REM DynamusicB2C and into DynamusicB2B,
REM and matching data source xml files
REM for the JBOSS side
REM ---------------------------------------------------

REM call dasenv.bat to set JBOSS_HOME from Dynamo config
call %DYNAMO_HOME%\localconfig\DASENV

echo - using JBOSS_HOME=%JBOSS_HOME%

xcopy dataSource_files\b2c\JTDataSource.properties %DYNAMO_HOME%\..\DynamusicB2C\config\atg\dynamo\service\jdbc /Q /Y
xcopy dataSource_files\b2b\JTDataSource.properties %DYNAMO_HOME%\..\DynamusicB2B\config\atg\dynamo\service\jdbc /Q /Y

xcopy dataSource_files\b2c\dynamusic-b2c-solid-ds.xml %JBOSS_HOME%\server\atg\deploy /Q /Y
xcopy dataSource_files\b2b\dynamusic-b2b-solid-ds.xml %JBOSS_HOME%\server\atg\deploy /Q /Y

REM ------------------------------------------------------
REM Copy SHORTCUTS to Desktop
REM ------------------------------------------------------

echo ++ copying shortcuts
if exist "c:\Documents and Settings\All Users\Desktop\COM_Shortcuts" (
   echo ++ "c:\Documents and Settings\All Users\Desktop\COM_Shortcuts" exists, deleting
   rmdir "c:\Documents and Settings\All Users\Desktop\COM_Shortcuts" /s /q 
)
xcopy COM_Shortcuts "c:\Documents and Settings\All Users\Desktop\COM_shortcuts" /I /Q /-Y



echo -- COMMERCE setup complete.  Be sure to start solid before starting the servers.

TIMEOUT /T 100


:end
echo -- exiting setup_COM