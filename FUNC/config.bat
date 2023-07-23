:: FUNC/CONFIG.BAT
:: Pulls from a configuration file and then makes assignments. only cares about lines with '='
::===============================================================================================::
START_FUNC
    SET "_result=%FALSE%"
    FOR %RAW_LINE in (%LOCAL_DIR%\%1) DO (
        ECHO "%RAW_LINE%" | FIND =
        IF "%ERRORLEVEL%" == "%TRUE%" (
            SET "%RAW_LINE%"
        )
    )
    SET "_result=%TRUE%"
END_FUNC
