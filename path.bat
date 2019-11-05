for /f "tokens=1,2*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "PATH"' ) DO (
    if "%%i"=="PATH" (
        set Value=%%k
    )
)

set last=%value:~-1%

if "%last%"==";" (
    setx /m path "%value%C:\ffmpeg\bin\;"
) else (
    setx /m path "%value%;C:\ffmpeg\bin\;"
)