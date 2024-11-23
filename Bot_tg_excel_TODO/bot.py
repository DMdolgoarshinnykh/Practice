import logging
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import (
    Application,
    CommandHandler,
    ContextTypes,
    ConversationHandler,
    CallbackQueryHandler, MessageHandler, filters
)
import parse_excel

class tg_bot:
    HALL_CHOICE, FIRST_NUMBER, SECOND_NUMBER, TEXT, CONFIRMATION, EDIT_CHOICE = range(6)
    def __init__(self, token, filename):
        self.parse_excel_obj = parse_excel.ParseExcel(filename)
        self.parse_excel_obj.read_excel_and_create_dict()
        self.token = token
        logging.basicConfig(
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            level=logging.INFO
        )

    async def start(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> int:
        context.user_data.clear()
        blocks = self.parse_excel_obj.get_blocks().keys()

        keyboard = [
            [InlineKeyboardButton(hall_name, callback_data=hall_name)] for hall_name in blocks
        ]
        sticker_id = "CAACAgIAAxkBAAENJNhnOkJiD70qbq9yvCvhhmJEbGj-2gACniQAAsfLCUkosRLLoZ4MYjYE"
        await update.message.reply_sticker(sticker_id)

        reply_markup = InlineKeyboardMarkup(keyboard)
        await update.message.reply_text("Выбери зал:", reply_markup=reply_markup)
        return self.HALL_CHOICE

    async def hall_choice(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> int:
      query = update.callback_query
      await query.answer()
      hall_choice = query.data.split("_")[1]
      context.user_data["hall"] = hall_choice
      keyboard = [[InlineKeyboardButton("Назад", callback_data="back_hall_choice")]]
      reply_markup = InlineKeyboardMarkup(keyboard)
      await query.edit_message_text(f"Выбран зал {hall_choice}, введите первое число", reply_markup=reply_markup)
      return self.FIRST_NUMBER

    async def get_first_number(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> int:
        try:
            context.user_data["first_number"] = int(update.message.text)
            keyboard = [[InlineKeyboardButton("Назад", callback_data="back_first_number")]]
            reply_markup = InlineKeyboardMarkup(keyboard)
            await update.message.reply_text("Введи второе число:", reply_markup=reply_markup)
            return self.SECOND_NUMBER
        except ValueError:
            keyboard = [[InlineKeyboardButton("Назад", callback_data="back_first_number")]]
            reply_markup = InlineKeyboardMarkup(keyboard)
            await update.message.reply_text("Введи, пожалуйста, целое число.", reply_markup=reply_markup)
            return self.FIRST_NUMBER

    async def get_second_number(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> int:
        try:
            context.user_data["second_number"] = int(update.message.text)
            keyboard = [[InlineKeyboardButton("Назад", callback_data="back_second_number")]]
            reply_markup = InlineKeyboardMarkup(keyboard)
            await update.message.reply_text("Введи строку:",reply_markup=reply_markup)
            return self.TEXT
        except ValueError:
            keyboard = [[InlineKeyboardButton("Назад", callback_data="back_second_number")]]
            reply_markup = InlineKeyboardMarkup(keyboard)
            await update.message.reply_text("Введи, пожалуйста, целое число.", reply_markup=reply_markup)
            return self.SECOND_NUMBER

    async def get_text(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> int:
        context.user_data["text"] = update.message.text
        first_number = context.user_data["first_number"]
        second_number = context.user_data["second_number"]
        text = context.user_data["text"]
        hall = context.user_data['hall']
        response_text = f"Вы ввели:\nЗал: {hall}\nПервое число: {first_number}\nВторое число: {second_number}\nСтрока: {text}"

        keyboard = [
            [InlineKeyboardButton("Изменить", callback_data="edit"),
             InlineKeyboardButton("Сохранить", callback_data="save")],
            [InlineKeyboardButton("Назад", callback_data="back_text")]
        ]
        reply_markup = InlineKeyboardMarkup(keyboard)

        await update.message.reply_text(response_text, reply_markup=reply_markup)
        return self.CONFIRMATION

    async def confirmation(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> int:
        query = update.callback_query
        await query.answer()
        choice = query.data

        if choice == "edit":
            keyboard = [
                [
                    InlineKeyboardButton("Первое число", callback_data="edit_first"),
                    InlineKeyboardButton("Второе число", callback_data="edit_second")
                ],
                [
                    InlineKeyboardButton("Строку", callback_data="edit_text"),
                     InlineKeyboardButton("Назад", callback_data="back_confirmation")
                ]
            ]
            reply_markup = InlineKeyboardMarkup(keyboard)

            await query.edit_message_text("Что вы хотите изменить?", reply_markup=reply_markup)
            return self.EDIT_CHOICE
        elif choice == "save":
            first_number = context.user_data["first_number"]
            second_number = context.user_data["second_number"]
            text = context.user_data["text"]
            hall = context.user_data["hall"]

            save_message = f"Данные сохранены:\nЗал: {hall} \nПервое число: {first_number}\nВторое число: {second_number}\nСтрока: {text}"
            await query.edit_message_text(save_message)
            return ConversationHandler.END
        elif choice.startswith("back_"):
          previous_state = choice.split("_")[1]
          if previous_state == "text":
            keyboard = [[InlineKeyboardButton("Назад", callback_data="back_second_number")]]
            reply_markup = InlineKeyboardMarkup(keyboard)
            await query.edit_message_text("Введите новую строку", reply_markup = reply_markup)
            return self.TEXT

    async def edit_choice(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> int:
      query = update.callback_query
      await query.answer()
      choice = query.data

      if choice == "edit_first":
        keyboard = [[InlineKeyboardButton("Назад", callback_data="back_edit_choice")]]
        reply_markup = InlineKeyboardMarkup(keyboard)
        await query.edit_message_text("Введите новое первое число:",reply_markup=reply_markup)
        return self.FIRST_NUMBER
      if choice == "edit_second":
        keyboard = [[InlineKeyboardButton("Назад", callback_data="back_edit_choice")]]
        reply_markup = InlineKeyboardMarkup(keyboard)
        await query.edit_message_text("Введите новое второе число:",reply_markup=reply_markup)
        return self.SECOND_NUMBER
      if choice == "edit_text":
        keyboard = [[InlineKeyboardButton("Назад", callback_data="back_edit_choice")]]
        reply_markup = InlineKeyboardMarkup(keyboard)
        await query.edit_message_text("Введите новую строку:",reply_markup=reply_markup)
        return self.TEXT
      if choice == "back_confirmation":
          first_number = context.user_data["first_number"]
          second_number = context.user_data["second_number"]
          text = context.user_data["text"]
          hall = context.user_data['hall']
          response_text = f"Вы ввели:\nЗал: {hall}\nПервое число: {first_number}\nВторое число: {second_number}\nСтрока: {text}"

          keyboard = [
              [InlineKeyboardButton("Изменить", callback_data="edit"),
               InlineKeyboardButton("Сохранить", callback_data="save")],
              [InlineKeyboardButton("Назад", callback_data="back_text")]
          ]
          reply_markup = InlineKeyboardMarkup(keyboard)

          await query.edit_message_text(response_text, reply_markup=reply_markup)
          return self.CONFIRMATION

    async def cancel(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> int:
        await update.message.reply_text("Диалог отменен.")
        return ConversationHandler.END
    async def go_back(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> int:
        query = update.callback_query
        await query.answer()
        previous_state = query.data.split("_")[1]

        if previous_state == "hall_choice":
            blocks = self.parse_excel_obj.get_blocks().keys()
            keyboard = [
                [InlineKeyboardButton(hall_name, callback_data=hall_name)] for hall_name in blocks
            ]
            reply_markup = InlineKeyboardMarkup(keyboard)
            await query.edit_message_text("Выбери зал:", reply_markup=reply_markup)
            return self.HALL_CHOICE
        if previous_state == "first_number":
          query = update.callback_query
          keyboard = [[InlineKeyboardButton("Назад", callback_data="back_hall_choice")]]
          reply_markup = InlineKeyboardMarkup(keyboard)
          await query.edit_message_text(f"Выбран зал {context.user_data['hall']}, введите первое число", reply_markup=reply_markup)
          return self.FIRST_NUMBER
        if previous_state == "second_number":
          keyboard = [[InlineKeyboardButton("Назад", callback_data="back_first_number")]]
          reply_markup = InlineKeyboardMarkup(keyboard)
          await query.edit_message_text("Введи первое число:",reply_markup=reply_markup)
          return self.FIRST_NUMBER

        if previous_state == "edit_choice":
          keyboard = [
              [InlineKeyboardButton("Изменить", callback_data="edit"),
               InlineKeyboardButton("Сохранить", callback_data="save")],
              [InlineKeyboardButton("Назад", callback_data="back_text")]
          ]
          reply_markup = InlineKeyboardMarkup(keyboard)
          await query.edit_message_text(f"Вы ввели:\nЗал: {context.user_data['hall']}\nПервое число: {context.user_data['first_number']}\nВторое число: {context.user_data['second_number']}\nСтрока: {context.user_data['text']}",reply_markup=reply_markup)
          return self.CONFIRMATION



    def run(self):
        application = Application.builder().token(self.token).build()

        conv_handler = ConversationHandler(
            entry_points=[CommandHandler("start", self.start)],
            states={
                self.HALL_CHOICE: [CallbackQueryHandler(self.hall_choice)],
                self.FIRST_NUMBER: [CallbackQueryHandler(self.go_back),MessageHandler(filters.TEXT & ~filters.COMMAND, self.get_first_number)],
                self.SECOND_NUMBER: [CallbackQueryHandler(self.go_back),MessageHandler(filters.TEXT & ~filters.COMMAND, self.get_second_number)],
                self.TEXT: [CallbackQueryHandler(self.go_back),MessageHandler(filters.TEXT & ~filters.COMMAND, self.get_text)],
                self.CONFIRMATION: [CallbackQueryHandler(self.confirmation)],
                self.EDIT_CHOICE: [CallbackQueryHandler(self.edit_choice)]

            },
            fallbacks=[CommandHandler("cancel", self.cancel), CallbackQueryHandler(self.go_back)],
        )

        application.add_handler(conv_handler)

        application.run_polling()