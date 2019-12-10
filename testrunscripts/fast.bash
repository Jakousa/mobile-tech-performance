#!/bin/bash

echo "Press [CTRL+C] to stop.."
i="0"

while [ $i -lt 15 ]
  do
    echo "Swiping more..."
    xmacroplay -d 5  "$DISPLAY" < fast.file
    sleep 1.5
    i=$[$i+1]
  done