#! /bin/bash
# "--bytest 5000000" is 500MB.
echo PID=$$
echo -n "[ Enter : powerup! ] , [ Ctrl+d : stop ]"
c=0
while read byte; do
 eval a$c'=$(head --bytes 5000000 /dev/zero |cat -v)'
 c=$(($c+1))
 echo -n ">"
done
echo
