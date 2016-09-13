@echo off
setlocal

rem ------------------------------------------------------------
rem   Commerce CLEANUP
rem 
REM this file attempts to clean up all of the files created by installing
REM Commerce student files and running the labs.

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

echo ** using ATGDIR= %ATGDIR%
REM call dasenv.bat to set JBOSS_HOME from Dynamo config
if exist %DYNAMO_HOME%\localconfig\dasEnv.bat (
   call %DYNAMO_HOME%\localconfig\dasEnv.bat
) else (
   echo %DYNAMO_HOME%\localconfig\dasEnv.bat not found, are you sure ATGDIR is set correctly?
   goto :end
)

REM -----------------------------------
REM delete current and saved directories
REM -----------------------------------

for %%d in (
	%ATGDIR%\DynamusicB2B
	%ATGDIR%\Loyalty
	%ATGDIR%\Loyalty2
	%ATGDIR%\LoyaltyFulfillment
	%ATGDIR%\DAS\solid\atgdb_com
	%ATGDIR%\DAS\solid\atgdb_com-save

) do (
   if exist %%d (
       echo ** deleting %%d
       rmdir %%d /s/q
   ) else echo ** Not found, ignoring: %%d
)	


TIMEOUT /T 100

:end
echo ** Commerce cleanup ALL complete.