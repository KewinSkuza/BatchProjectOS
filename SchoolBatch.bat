@ECHO OFF
rem --FIND WINDOWS VERSION--
rem -- VER is a windows command that shows the version, the rest of the statement looks for a string (/I ignores upper and lower case) contaning the networking technology (NT) version --
rem -- if the error level is equal to zero the script sets the verison variable to the following windows version --
rem -- NUL reports no data to the console --

VER | FINDSTR /I "5.0." > NUL
IF %ERRORLEVEL% EQU 0 (SET Version=Windows 2000)

VER | FINDSTR /I "5.1." > NUL
IF %ERRORLEVEL% EQU 0 (SET Version=Windows XP)

VER | FINDSTR /I "5.2." > NUL
IF %ERRORLEVEL% EQU 0 (SET Version=Windows XP x64)

VER | FINDSTR /I "6.0." > NUL
IF %ERRORLEVEL% EQU 0 (SET Version=Windows Vista)

VER | FINDSTR /I "6.1." > NUL
IF %ERRORLEVEL% EQU 0 (SET Version=Windows 7)

VER | FINDSTR /I "6.2." > NUL
IF %ERRORLEVEL% EQU 0 (SET Version=Windows 8)

VER | FINDSTR /I "6.3." > NUL
IF %ERRORLEVEL% EQU 0 (SET Version=Windows 8.1)

VER | FINDSTR /I "10.0." > NUL
IF %ERRORLEVEL% EQU 0 (SET Version=Windows 10)

:MENU 
rem --The double colon sets an anchor -> this is a 'bookmark' which shows the program to go back to a point and execute the commands-- 

rem --THIS IS THE VISUAL MENU--
cls
ECHO. 
rem --A full stop straight after a echo command skips a line--
ECHO ....................................................... 
rem --A space prints the following text--
ECHO PRESS 1, 2 OR 3 etc. to select your task, or 9 to EXIT.
ECHO .......................................................
ECHO.
ECHO 1 - Display User/PC Info
ECHO 2 - Check Create Directory Structure
ECHO 3 - Create Logfile
ECHO 4 - Backup Logfile
ECHO 5 - File Comparison 
ECHO 6 - View File Attributes
ECHO 7 - View Folder Permissions
ECHO 8 - List Non-System Processes
ECHO.
ECHO 9 - Exit
ECHO.
ECHO Type your preferred option and then press Enter
ECHO.

rem --THIS IS THE INPUT AREA--
SET /P M=
rem --SET command allows the user to change a variable/string to another (example: Changes the "1" input to GOTO D_U/P_I command)--
rem -- /P = wait for user input, the M= is the variable used --
rem --The GOTO command sends the user to the specified bookmark--
IF %M%==1 GOTO Display_Info
IF %M%==2 GOTO Create_Directory_Structure
IF %M%==3 GOTO Create_LogFile
IF %M%==4 GOTO Backup_LogFile
IF %M%==5 GOTO Compare_Files
IF %M%==6 GOTO File_Attributes
IF %M%==7 GOTO Folder_Permissions
IF %M%==8 GOTO Non-System_Processes
IF %M%==9 GOTO Exit

rem --THIS IS THE COMMAND SECTION--
rem -> Case 1
:Display_Info
CLS
ECHO Hello %username%, you are currently logged into %computername% 
ECHO It is %time%, on %date%
ECHO You are using a PC that is running %version%
rem --The pause command makes the user to press enter before moving onto the next command--
ECHO.
PAUSE
GOTO MENU

rem -> Case 2
:Create_Directory_Structure
CLS 
MD c:\batch\logs
MD c:\backup\logs
ECHO.
PAUSE
GOTO MENU

rem -> Case 3
:Create_LogFile
CLS
rem -- >> means that a log file is being created as the following file --
IF NOT EXIST "c:\batch\logs\logfile.txt" (
rem -- If the file doesnt exit create it --
ECHO Hello %username%, you are currently logged into %computername% >> "c:\batch\logs\logfile.txt"
ECHO It is %time%, on %date% >> "c:\batch\logs\logfile.txt"
ECHO You are using a PC that is running %version% >> "c:\batch\logs\logfile.txt"
ECHO.
ECHO LogFile created
ECHO.
) ELSE (
rem -- If it does exist update it --
ECHO Hello %username%, you are currently logged into %computername% >> "c:\batch\logs\logfile.txt"
ECHO It is %time%, on %date% >> "c:\batch\logs\logfile.txt"
ECHO You are using a PC that is running %version% >> "c:\batch\logs\logfile.txt"
ECHO.
ECHO LogFile updated
ECHO.
)
PAUSE
GOTO MENU

rem -> Case 4
:Backup_LogFile
CLS
COPY "c:\batch\logs\logfile.txt" "c:\backup\logs\logfile.txt"
CLS
ECHO.
ECHO Backed up
ECHO.
PAUSE
GOTO MENU

rem -> Case 5
:Compare_Files
CLS
FC "c:\batch\logs\logfile.txt" "c:\backup\logs\logfile.txt"
ECHO.
rem -- FC = file compare command --
rem -- the output shows the missing contents of the file comparement --
PAUSE
GOTO MENU

rem -> Case 6
:File_Attributes
CLS
attrib c:\batch\logs\logfile.txt
ECHO.
ECHO R = Read Only
ECHO H = Hidden
ECHO S = System
ECHO A = Archive 
ECHO C = Compressed
ECHO N = Not Indexed
ECHO L = Reparse Points
ECHO O = Offline
ECHO P = Sparse File
ECHO I = Not content indexed
ECHO T = Temporary
ECHO E = Encrypted
ECHO.
PAUSE
GOTO MENU

rem -> Case 7
:Folder_Permissions
rem -- cacls stands for control access control list --
rem -- cacls shows all of thf file rights --
CLS
CACLS c:\backup
ECHO.
ECHO R = Read
ECHO W = Write
ECHO C = Change (read/write) 
ECHO F = Full control
ECHO N = None
ECHO.
ECHO For inheritance permissions search "cacls /?"
ECHO.
PAUSE
GOTO MENU

rem -> Case 8
:Non-System_Processes
CLS
rem -- /FI = filter | ne = not equal | NT AUTHORITY\SYSTEM = neither a group or an account is displayed as a system | eq = equal --
TASKLIST /FI "USERNAME ne NT AUTHORITY\SYSTEM" /FI "STATUS eq running"
ECHO.
PAUSE
GOTO MENU

rem -> Case 9
:Exit
CLS


  