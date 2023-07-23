::HAZEL/main.bat
::Ilobmirt - 2023-JUL-23
::GPLv3 - Pulls other github projects to your DOS system
@ECHO OFF

SET "NOT_SET=>>NOT SET<<"
SET /E LOCAL_DIR=cd
SET FUNC_DIR=%LOCAL_DIR%/FUNC

SET "GITHUB_USER=%NOT_SET%"
SET "GITHUB_PROJECT=%NOT_SET%"
SET "GITHUB_BRANCH=%NOT_SET%"
SET "PROJECTS_BASE_DIR=%NOT_SET%"

:START
 
 CALL "%FUNC_DIR%/prereq.bat" curl
 CALL "%FUNC_DIR%/prereq.bat" tar

 IF "%GITHUB_USER%" == "%NOT_SET%" SET "%GITHUB_USER%=%1"
 IF "%GITHUB_PROJECT%" == "%NOT_SET%" SET "%GITHUB_PROJECT%=%2"
 IF "%GITHUB_BRANCH%" == "%NOT_SET%" SET "%GITHUB_BRANCH%=%3"

 ::CALL_FUNC_config.bat config.txt
 CALL_FUNC_show_config.bat

:END
