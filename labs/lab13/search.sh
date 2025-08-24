#!/bin/bash


# Инициализация переменных
inputfile=""          # Путь к входному файлу (ключ -i)
outputfile=""         # Путь к выходному файлу (ключ -o)
pattern=""            # Шаблон для поиска (ключ -p)
case_sensitive=0      # Флаг чувствительности к регистру (0 - выключено, ключ -C)
show_numbers=0        # Флаг вывода номеров строк (0 - выключено, ключ -n)

# Обработка ключей с помощью getopts
# Опции:
#   i: - требует аргумент (inputfile)
#   o: - требует аргумент (outputfile)
#   p: - требует аргумент (pattern)
#   C  - без аргумента (включает чувствительность к регистру)
#   n  - без аргумента (включает вывод номеров строк)
while getopts ":i:o:p:Cn" opt; do
  case $opt in
    i) inputfile="$OPTARG" ;;          # Сохраняем аргумент после -i в inputfile
    o) outputfile="$OPTARG" ;;         # Сохраняем аргумент после -o в outputfile
    p) pattern="$OPTARG" ;;            # Сохраняем аргумент после -p в pattern
    C) case_sensitive=1 ;;             # Включаем чувствительность к регистру
    n) show_numbers=1 ;;               # Включаем вывод номеров строк
    \?) echo "Неверный ключ: -$OPTARG" >&2; exit 1 ;;  # Ошибка: неизвестный ключ
    :) echo "Ключ -$OPTARG требует аргумент." >&2; exit 1 ;;  # Ошибка: пропущен аргумент
  esac
done

# Проверка обязательных параметров
# Если inputfile или pattern не указаны, выводим подсказку и завершаем скрипт
if [ -z "$inputfile" ] || [ -z "$pattern" ]; then
  echo "Использование: $0 -i inputfile -p pattern [-o outputfile] [-C] [-n]"
  exit 1
fi

# Проверка существования входного файла
if [ ! -f "$inputfile" ]; then
  echo "Файл $inputfile не существует" >&2
  exit 1
fi

# Формирование команды grep
grep_cmd="grep"       # Базовая команда grep

# Добавляем опции в зависимости от флагов:
if [ $case_sensitive -eq 1 ]; then
  grep_cmd="$grep_cmd"    # Чувствительность к регистру (по умолчанию в grep)
else
  grep_cmd="$grep_cmd -i" # Игнорировать регистр (ключ -i)
fi

if [ $show_numbers -eq 1 ]; then
  grep_cmd="$grep_cmd -n" # Показать номера строк (ключ -n)
fi

# Добавляем шаблон и входной файл
grep_cmd="$grep_cmd \"$pattern\" \"$inputfile\""

# Вывод результатов
if [ -z "$outputfile" ]; then
  # Если outputfile не указан, выводим результат в консоль
  eval "$grep_cmd"
else
  # Если outputfile указан, перенаправляем вывод в файл
  eval "$grep_cmd" > "$outputfile"
  echo "Результаты сохранены в $outputfile"
fi
