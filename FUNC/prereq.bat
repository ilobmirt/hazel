:: FUNC/PREREQ.BAT
:: Tests for and installs the application if needed. Uses FREEDos' fdnpkg utility
::===============================================================================================::
ECHO "===FUNC:PREREQ==="
ECHO "Checking system for program --> %1"

fdnpkg listlocal "%1" | find "%1" > nul

GOTO A_EC%ERRORLEVEL%

:A_EC0
ECHO "%1 -- PACKAGE ALREADY INSTALLED"
GOTO END

:A_EC1
fdnpkg search "%1" | find "%1" > nul
GOTO B_EC%ERRORLEVEL%

:B_EC0
fdnpkg install "%1"
GOTO END

:B_EC1
ECHO "%1 -- FAILED to INSTALL PREREQ PACKAGE"

:END