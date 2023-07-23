:: FUNC/SHOW_CONFIG.BAT
:: Displays the project configuration
::===============================================================================================::
START_FUNC
    SET "_result=%FALSE%"

    ECHO "USER: %GITHUB_USER%"
    ECHO "PROJECT: %GITHUB_PROJECT%"
    ECHO "BRANCH: %GITHUB_BRANCH%"
    ECHO "DOWNLOAD DIR: %PROJECTS_BASE_DIR%"

    SET "_result=%TRUE%"
END_FUNC