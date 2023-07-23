:: FUNC/PREREQ.BAT
:: Tests for and installs the application if needed. Uses FREEDos' fdnpkg utility
::===============================================================================================::
START_FUNC
    SET "_result=%FALSE%"
    ECHO "===FUNC:PREREQ==="
    ECHO "Checking system for program --> %1"
    fdnpkg listlocal "%1" | find "%1"
    IF "%ERRORLEVEL%" == "%FALSE%" (
		fdnpkg install %1
	)
    SET "_result=%TRUE%"
END_FUNC