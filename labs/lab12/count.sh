#!/bin/bash
if [ $# -ne 2 ]; then
 echo "Использование: $0 <расширение> <директория>"
fi
extension=$1
directory=$2
count=$(find "$directory" -type f -name "*.$extension" | wc -l)
echo "Количество файлов с расширением ".$extension" в "$directory: $count""
