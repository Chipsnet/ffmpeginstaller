@echo off
cls

: ====================================
:    ffmpeg installer  by Minato86
: ====================================

: タイトル表示
color 0A
echo ==================================
echo    ffmpeg installer by Minato86
echo ==================================

: ファイルダウンロード確認
:download
set /P download="ファイルはダウンロード済みですか？（y/n）: "

if ""%download%""=="""" ( 
    goto inputpath
) 
if %download%==n (
    echo ダウンロードページを開きました。ダウンロードが完了したら何かキーを押してください...
    start https://ffmpeg.zeranoe.com/builds/
    pause > nul
)

: ファイルパス入力
:inputpath
set /P zippath="ダウンロードしたzipファイルをドラッグアンドドロップしてください: "

if ""%zippath%""=="""" (
    echo Error: ファイルがドラッグアンドドロップされていません。
    goto inputpath
)

: 7zipの確認
:check7zip
if exist "C:\Program Files\7-Zip\7z.exe" (
    echo info: 7zipはインストールされています。
    goto unzip
) else (
    goto dl7zip
)

: 7zipのダウンロード
:dl7zip
echo 7zipがインストールされていません。ダウンロードされるファイルをインストール後何かキーを押してください...
if "%PROCESSOR_ARCHITECTURE%" EQU "x86" (
    start https://ja.osdn.net/projects/sevenzip/downloads/70662/7z1900.exe/
) 
if "%PROCESSOR_ARCHITECTURE%" NEQ "x86" (
    start https://ja.osdn.net/projects/sevenzip/downloads/70662/7z1900-x64.exe/
)
pause > nul
goto check7zip

: ファイルの解凍
:unzip
echo info: %zippath% の解凍を開始します。
set now_path=%~dp0
set unzip_path="%~dp0"
"C:\Program Files\7-Zip\7z.exe" x -y -o%unzip_path% "%zippath%"
echo info: %zippath% の解凍を完了しました。

: フォルダ名の変更
echo info: 解凍されたファイルを確認しています...
for /d %%f in (ffmpeg*) do (
    rename %%f ffmpeg
    echo info: 解凍されたフォルダ %%f を ffmpeg に変更しました。
)

: Cドライブへコピー
set install_path=C:\ffmpeg\
echo info: %install_path% にffmpegをインストールします。
xcopy /e "%now_path%ffmpeg" "%install_path%"

: Pathの設定
echo info: pathを設定します。
powershell start-process path.bat -verb runas

: 一時ファイルの削除
echo info: 一時ファイルのクリーンアップ中...
for /d %%f in (ffmpeg*) do (
    rd /s /q %%f
    echo info: 一時ファイル %%f を削除しました。
)

: 終了メッセージ
echo インストールが完了しました！終了するには何かキーを押してください...

pause > nul