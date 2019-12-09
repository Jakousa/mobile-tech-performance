#!/bin/bash
echo "Press [CTRL+C] to stop.."
echo "Start:" `date +'%s'` >> data.txt
while :
  do
    data=`~/Library/Android/sdk/platform-tools/adb shell dumpsys meminfo |grep "flutter"`
    echo $data'||'`date +'%s'` >> data.txt
    sleep 1
  done