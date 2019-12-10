#!/bin/bash
echo "Press [CTRL+C] to stop.."
echo "Start:" `date +'%s'` >> data.txt
i=1
while :
  do
    chrome_mem=`~/Library/Android/sdk/platform-tools/adb shell dumpsys meminfo |grep "chrome:" |sed -e 's/   *//g' | sort | uniq| cut -d ':' -f 1 |cut -d 'K' -f 1 |sed -e 's/,//g' |awk 'BEGIN {sum=0} { sum += $1 } END { print sum }'`
    echo $chrome_mem '||' $i >> data.txt
    i=$((i + 1))
    sleep 1
  done