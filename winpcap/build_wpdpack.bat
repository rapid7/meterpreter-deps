@echo off

if "%2"== "" ( rd /s/q ./wpdpack 2>nul >nul) else ( rd /s /q "%2" 2>nul >nul)

call create_include.bat %1 %2
PAUSE
call create_lib.bat %1 %2
PAUSE
call create_examples.bat %1 %2
PAUSE
call create_docs.bat %1 %2


