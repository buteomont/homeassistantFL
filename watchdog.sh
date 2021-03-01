#!/bin/sh
FIXUP_SERVICE='/home/pi/apps/hassHelpers/fixup.py'
RADIO_SERVICE='/usr/local/bin/rtl_433'

#echo "Checking $FIXUP_SERVICE ..." 
#if ! ps ax | grep -v grep | grep $FIXUP_SERVICE > /dev/null
#then
#    echo "`date`: restarting $FIXUP_SERVICE"
#    /usr/bin/python3 $FIXUP_SERVICE >>/home/pi/logs/fixup.log 2>&1 &
#fi

echo "Checking $RADIO_SERVICE ..." 
if ! ps ax | grep -v grep | grep $RADIO_SERVICE > /dev/null
then
    echo "`date`: restarting $RADIO_SERVICE"
    $RADIO_SERVICE -f 433.92M -f 915M -H 63 -M level -R 75 -R 35 -R 40 -R 30 -X 'n=PIR sensor,m=OOK_PWM,s=384,l=1188,r=1232,g=0,t=320,y=0,invert,preamble=1ef689' -F mqtt:192.168.1.99:1883,user=mqtt,pass=tinymqtt,retain=1 >>/home/pi/logs/rtl433.log 2>&1 &
fi

