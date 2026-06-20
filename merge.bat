@echo off
REM ============================================================
REM  Build a single merged.bin for phone/browser flashing.
REM  Run AFTER "pio run" (so the .bin parts exist).
REM ============================================================
setlocal
set B=.pio\build\esp32dev

pio pkg exec -- esptool.py --chip esp32 merge_bin -o flasher\merged.bin ^
  --flash_mode dio --flash_freq 40m --flash_size 4MB ^
  0x1000  %B%\bootloader.bin ^
  0x8000  %B%\partitions.bin ^
  0x10000 %B%\firmware.bin

if errorlevel 1 (
  echo.
  echo esptool.py not found? Try:  python -m esptool ...   or
  echo   pio pkg exec -- esptool.py ...
) else (
  echo.
  echo Done -^> flasher\merged.bin  ^(host the flasher\ folder on GitHub Pages^)
)
endlocal