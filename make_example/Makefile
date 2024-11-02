CXX = g++
CXXFLAGS = -Wall

MAKEFILE_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

EXE = my_program

my_dir:
	@echo "==================="
	@echo "Создание директории my_dir в: $(MAKEFILE_DIR)"
	mkdir -p $(MAKEFILE_DIR)my_dir
	@echo "Директория my_dir создана"
	@echo "==================="

move_source: my_dir
	@echo "==================="
	@echo "Перемещение файла main.cpp в директорию my_dir"
	mv $(MAKEFILE_DIR)/main.cpp $(MAKEFILE_DIR)/my_dir/
	@echo "Файл main.cpp перемещен в my_dir"
	@echo "==================="

compile: move_source
	@echo "==================="
	@echo "Компиляция main.cpp в исполняемый файл"
	$(CXX) $(CXXFLAGS) -o $(MAKEFILE_DIR)/my_dir/$(EXE) $(MAKEFILE_DIR)/my_dir/main.cpp
	@echo "Компиляция завершена. Исполняемый файл создан: $(MAKEFILE_DIR)/my_dir/$(EXE)"
	@echo "==================="

run: compile
	@echo "==================="
	@echo "Запуск исполняемого файла:"
	$(MAKEFILE_DIR)/my_dir/$(EXE)
	@echo "Исполняемый файл запущен"
	@echo "==================="

show_directories: run
	@echo "==================="
	@echo "Список директорий Linux и их описание:"
	@echo "/bin - Содержит исполняемые файлы базовых утилит."
	@echo "/sbin - Содержит системные исполняемые файлы."
	@echo "/usr - Содержит пользовательские программы и данные."
	@echo "/usr/local - Место для локально установленных программ."
	@echo "/opt - Обычно используется для дополнительных программ."
	@echo "/etc - Содержит конфигурационные файлы."
	@echo "/var - Содержит файлы переменных данных."
	@echo "/home - Домашние директории пользователей."
	@echo "/root - Домашняя директория суперпользователя."
	@echo "/dev - Содержит файлы устройств."
	@echo "/lib - Содержит библиотеки."
	@echo "/media и /mnt - Точки монтирования для съемных устройств."
	@echo "/tmp - Временные файлы."
	@echo "==================="

all: show_directories

.PHONY: my_dir move_source compile run show_directories all
