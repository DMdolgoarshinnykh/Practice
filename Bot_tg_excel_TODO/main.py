
from bot import tg_bot


def main():
    """Основная функция программы."""
    TOKEN = "hello"
    filename = "hello"
    bot = tg_bot(TOKEN, filename)
    bot.run()
    #for block_name, block_data in blocks.items():
    #    print(f"\n--- Блок: {block_name} ---")
    #    for row in block_data:
    #        print(row)
    #first_block_name = list(blocks.keys())[1]

    #changes = [
    #    (2, 1, "Имя"),  # Записать "Имя" в ячейку A1
    #    (2, 2, "Возраст"),  # Записать "Возраст" в ячейку B1
    #    (3, 1, "Иван"),  # Записать "Иван" в ячейку A2
    #    (3, 2, 30)  # Записать 30 в ячейку B2
    #]
    #parse_excel_obj.write_multiple_to_excel(changes)
    #print(f"Изменения сохранены в '{filename}'.")

if __name__ == "__main__":
    main()