#!/bin/bash
echo "Всего аргументов: $#"
echo "Список аргументов:"

count=1
for arg in "$@"; do
	echo "Аргумент $count: $arg"
	((count++))
done

