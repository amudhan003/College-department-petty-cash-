@echo off
setlocal enabledelayedexpansion
title AIHT CSBS Petty Cash System - 1-Click Launcher
color 0B

echo ===============================================================================
echo   AIHT CSBS CAPSTONE PROJECT: PETTY CASH & BUDGET APPROVAL SYSTEM
echo   Team ID: CSBS-G01 | Department: Computer Science & Business Systems
echo   Team Members:
echo     1. R. Adhya Mishra (310125244002) - Lead & System Architect
echo     2. S. Amudhan (310125244003)      - Frontend Specialist
echo     3. R. Anjali (310125244004)       - Backend & API Specialist
echo ===============================================================================
echo.

:: -----------------------------------------------------------------------------
:: Step 1: Detect and Verify Java 17+
:: -----------------------------------------------------------------------------
echo [STEP 1/4] Checking Java Runtime Environment...

set "JAVA_CMD=java"
%JAVA_CMD% -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    if defined JAVA_HOME (
        if exist "%JAVA_HOME%\bin\java.exe" (
            set "JAVA_CMD=%JAVA_HOME%\bin\java.exe"
            set "PATH=%JAVA_HOME%\bin;%PATH%"
            echo   Found Java in JAVA_HOME: %JAVA_HOME%
        )
    )
)

%JAVA_CMD% -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    if exist "C:\Program Files\Android\Android Studio\jbr\bin\java.exe" (
        set "JAVA_CMD=C:\Program Files\Android\Android Studio\jbr\bin\java.exe"
        set "PATH=C:\Program Files\Android\Android Studio\jbr\bin;%PATH%"
        set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"
        echo   Detected OpenJDK in Android Studio JBR runtime!
    )
)

%JAVA_CMD% -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo   [WARNING] Java executable was not found in PATH or standard directories.
    echo   Please ensure JDK 17+ is installed and configured in PATH.
) else (
    echo   [OK] Java Runtime detected successfully.
    "%JAVA_CMD%" -version
)
echo.

:: -----------------------------------------------------------------------------
:: Step 2: Check MySQL 8.0 on Port 3306
:: -----------------------------------------------------------------------------
echo [STEP 2/4] Verifying MySQL Database service on port 3306...
powershell -Command "if (Test-NetConnection -ComputerName localhost -Port 3306 -InformationLevel Quiet) { exit 0 } else { exit 1 }" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [OK] MySQL Service is actively listening on localhost:3306.
    echo   Target database: pettycash_db
) else (
    echo   [NOTICE] MySQL port 3306 was not detected as open.
    echo   If you use MySQL, please ensure mysqld / XAMPP / WAMP MySQL service is started.
    echo   (Note: Spring Boot will also attempt automatic connectivity per application.properties)
)
echo.

:: -----------------------------------------------------------------------------
:: Step 3: Launch Spring Boot Backend
:: -----------------------------------------------------------------------------
echo [STEP 3/4] Launching Application Tier (Spring Boot REST Engine on port 8080)...
set "BACKEND_DIR=%~dp0backend"

where mvn >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    start "AIHT CSBS Backend - Spring Boot (:8080)" cmd /k "cd /d "%BACKEND_DIR%" && echo Starting Spring Boot Application... && mvn spring-boot:run"
    echo   [OK] Spring Boot service launched in dedicated background terminal.
) else (
    echo   [NOTICE] 'mvn' command was not detected in PATH.
    echo   To compile and run backend via Maven:
    echo     1. Install Maven or add it to PATH.
    echo     2. Run: cd backend ^&^& mvn spring-boot:run
    echo.
    echo   Starting presentation and frontend portal immediately...
)
echo.

:: -----------------------------------------------------------------------------
:: Step 4: Wait and Launch Frontend Portal
:: -----------------------------------------------------------------------------
echo [STEP 4/4] Waiting 10 seconds for service initialization...
timeout /t 10 /nobreak >nul

set "FRONTEND_FILE=%~dp0frontend\index.html"
set "PRESENTATION_FILE=%~dp0presentation\index.html"

echo Opening Frontend Portal in default browser...
start "" "%FRONTEND_FILE%"

echo Opening Capstone Presentation Slide Deck in browser...
start "" "%PRESENTATION_FILE%"

echo.
echo ===============================================================================
echo   PROJECT INITIALIZATION COMPLETE!
echo   - Presentation Tier: %FRONTEND_FILE%
echo   - Slide Deck:        %PRESENTATION_FILE%
echo   - Application Tier:  http://localhost:8080/api/expenses
echo   - Database Schema:   %BACKEND_DIR%\src\main\resources\schema.sql
echo ===============================================================================
pause
