import os
import psycopg2
from psycopg2.extras import RealDictCursor

def get_db_connection():
    conn = psycopg2.connect(
        host=os.getenv('DATABASE_HOST', 'localhost'),
        port=os.getenv('DATABASE_PORT', 5432),
        dbname=os.getenv('DATABASE_NAME', 'mydb'),
        user=os.getenv('DATABASE_USER', 'user'),
        password=os.getenv('DATABASE_PASSWORD', 'password')
    )
    return conn

def fetch_items():
    conn = get_db_connection()
    cursor = conn.cursor(cursor_factory=RealDictCursor)
    cursor.execute('SELECT * FROM items;')
    items = cursor.fetchall()
    cursor.close()
    conn.close()
    return items

def handle_output_command():
    items = fetch_items()
    if items:
        print(f"{'ID':<5} {'Name':<20} {'Description':<50}")
        print("-" * 80)
        for item in items:
            print(f"{item['id']:<5} {item['name']:<20} {item.get('description', 'Нет описания'):<50}")
    else:
        print("Нет доступных данных в таблице 'items'.")

def main():
    print("Программа запущена. Введите 'Вывод' для получения данных из базы или 'exit' для выхода.")
    
    while True:
        command = input("Введите команду: ").strip().lower()
        
        if command == 'вывод':
            handle_output_command()
        elif command == 'exit':
            print("Завершение программы.")
            break
        else:
            print(f"Неизвестная команда: {command}. Попробуйте снова.")

if __name__ == "__main__":
    main()


