#!/bin/bash
tar -czf ~/backup/backup_script_$(date +%Y%m%d_%H%M%S).tar.gz $0
echo "Успешно создано"
