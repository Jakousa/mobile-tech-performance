#!/bin/bash

echo "Press [CTRL+C] to stop.."
i="0"

while [ $i -lt 10 ]
  do
    echo "Swiping more..."
    xmacroplay "$DISPLAY" < normal.file
    sleep 2
    i=$[$i+1]
  done