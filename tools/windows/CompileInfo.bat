@ECHO OFF

REM setup all paths
SET cur_dir=%CD%
SET base_dir=%cur_dir%\..\..
SET builddeps_dir=%cur_dir%\..\..\project\BuildDependencies
SET bin_dir=%builddeps_dir%\bin
SET msys_bin_dir=%builddeps_dir%\msys\bin

REM read the version values from version.txt
FOR /f %%i IN ('%msys_bin_dir%\awk.exe "/VERSION_MAJOR/ {print $2}" %base_dir%\version.txt') DO SET major=%%i
FOR /f %%i IN ('%msys_bin_dir%\awk.exe "/VERSION_MINOR/ {print $2}" %base_dir%\version.txt') DO SET minor=%%i
FOR /f %%i IN ('%msys_bin_dir%\awk.exe "/VERSION_TAG/ {print $2}" %base_dir%\version.txt') DO SET tag=%%i
FOR /f %%i IN ('%msys_bin_dir%\awk.exe "/ADDON_API/ {print $2}" %base_dir%\version.txt') DO SET addon_api=%%i

REM create the files with the proper version information
"%msys_bin_dir%\sed.exe" -e s/@APP_VERSION_MAJOR@/%major%/g -e s/@APP_VERSION_MINOR@/%minor%/g -e s/@APP_VERSION_TAG@/%tag%/g "%base_dir%\xbmc\CompileInfo.cpp.in" > "%base_dir%\xbmc\CompileInfo.cpp"
"%msys_bin_dir%\sed.exe" s/@APP_ADDON_API@/%addon_api%/g "%base_dir%\addons\xbmc.addon\addon.xml.in" > "%base_dir%\addons\xbmc.addon\addon.xml"

