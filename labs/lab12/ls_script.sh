#!/bin/bash
echo "Содержимое каталога $dir:"
echo "------------------------------"
for item in "$dir"/*; do
	if [ -d "$item" ]; then
	type = "Catalog"
	elif [ -f "$item" ]; then
	type = "File"
	else 
	type = "asofsjdfnj"
	fi
permissions= $(stat -c "%A" "$item")
echo "$type: $(basename "item") | Права: $permissions"
done
