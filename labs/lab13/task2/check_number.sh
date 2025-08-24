gcc number_check.c -o number_check

#!/bin/bash
./number_check
status=$?

case $status in
  0) echo "Число равно нулю";;
  1) echo "Число больше нуля";;
  2) echo "Число меньше нуля";;
  *) echo "Неизвестный статус";;
esac
