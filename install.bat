@echo off
cls

: ====================================
:    ffmpeg installer  by Minato86
: ====================================

: �^�C�g���\��
color 0A
echo ==================================
echo    ffmpeg installer by Minato86
echo ==================================

: �t�@�C���_�E�����[�h�m�F
:download
set /P download="�t�@�C���̓_�E�����[�h�ς݂ł����H�iy/n�j: "

if ""%download%""=="""" ( 
    goto inputpath
) 
if %download%==n (
    echo �_�E�����[�h�y�[�W���J���܂����B�_�E�����[�h�����������牽���L�[�������Ă�������...
    start https://ffmpeg.zeranoe.com/builds/
    pause > nul
)

: �t�@�C���p�X����
:inputpath
set /P zippath="�_�E�����[�h����zip�t�@�C�����h���b�O�A���h�h���b�v���Ă�������: "

if ""%zippath%""=="""" (
    echo Error: �t�@�C�����h���b�O�A���h�h���b�v����Ă��܂���B
    goto inputpath
)

: 7zip�̊m�F
:check7zip
if exist "C:\Program Files\7-Zip\7z.exe" (
    echo info: 7zip�̓C���X�g�[������Ă��܂��B
    goto unzip
) else (
    goto dl7zip
)

: 7zip�̃_�E�����[�h
:dl7zip
echo 7zip���C���X�g�[������Ă��܂���B�_�E�����[�h�����t�@�C�����C���X�g�[���㉽���L�[�������Ă�������...
if "%PROCESSOR_ARCHITECTURE%" EQU "x86" (
    start https://ja.osdn.net/projects/sevenzip/downloads/70662/7z1900.exe/
) 
if "%PROCESSOR_ARCHITECTURE%" NEQ "x86" (
    start https://ja.osdn.net/projects/sevenzip/downloads/70662/7z1900-x64.exe/
)
pause > nul
goto check7zip

: �t�@�C���̉�
:unzip
echo info: %zippath% �̉𓀂��J�n���܂��B
set now_path=%~dp0
set unzip_path="%~dp0"
"C:\Program Files\7-Zip\7z.exe" x -y -o%unzip_path% "%zippath%"
echo info: %zippath% �̉𓀂��������܂����B

: �t�H���_���̕ύX
echo info: �𓀂��ꂽ�t�@�C�����m�F���Ă��܂�...
for /d %%f in (ffmpeg*) do (
    rename %%f ffmpeg
    echo info: �𓀂��ꂽ�t�H���_ %%f �� ffmpeg �ɕύX���܂����B
)

: C�h���C�u�փR�s�[
set install_path=C:\ffmpeg\
echo info: %install_path% ��ffmpeg���C���X�g�[�����܂��B
xcopy /e "%now_path%ffmpeg" "%install_path%"

: Path�̐ݒ�
echo info: path��ݒ肵�܂��B
powershell start-process path.bat -verb runas

: �ꎞ�t�@�C���̍폜
echo info: �ꎞ�t�@�C���̃N���[���A�b�v��...
for /d %%f in (ffmpeg*) do (
    rd /s /q %%f
    echo info: �ꎞ�t�@�C�� %%f ���폜���܂����B
)

: �I�����b�Z�[�W
echo �C���X�g�[�����������܂����I�I������ɂ͉����L�[�������Ă�������...

pause > nul