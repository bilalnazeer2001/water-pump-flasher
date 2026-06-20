#!/usr/bin/env bash
# ============================================================
#  Build a single merged.bin for phone/browser flashing.
#  Run AFTER "pio run" (so the .bin parts exist).
# ============================================================
set -e
B=.pio/build/esp32dev

esptool.py --chip esp32 merge_bin -o flasher/merged.bin \
  --flash_mode dio --flash_freq 40m --flash_size 4MB \
  0x1000  "$B/bootloader.bin" \
  0x8000  "$B/partitions.bin" \
  0x10000 "$B/firmware.bin"

echo "Done -> flasher/merged.bin  (host the flasher/ folder on GitHub Pages)"
