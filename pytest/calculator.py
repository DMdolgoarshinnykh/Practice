import sys
from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, 
                            QGridLayout, QPushButton, QLineEdit)
from PyQt6.QtCore import Qt
from PyQt6.QtGui import QFont

class Calculator(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Калькулятор")
        self.setFixedSize(350, 500)
        self.setStyleSheet("""
            QMainWindow {
                background-color: #f0f0f0;
            }
            QLineEdit {
                background-color: white;
                border: 2px solid #c0c0c0;
                border-radius: 5px;
                font-size: 24px;
                padding: 5px;
            }
            QPushButton {
                background-color: white;
                border: 1px solid #c0c0c0;
                border-radius: 5px;
                font-size: 18px;
            }
            QPushButton:hover {
                background-color: #e0e0e0;
            }
            QPushButton:pressed {
                background-color: #d0d0d0;
            }
        """)
        
        # Создаем центральный виджет и сетку
        self.centralWidget = QWidget()
        self.setCentralWidget(self.centralWidget)
        self.gridLayout = QGridLayout(self.centralWidget)
        self.gridLayout.setSpacing(10)
        self.gridLayout.setContentsMargins(20, 20, 20, 20)

        # Создаем поле вывода
        self.display = QLineEdit()
        self.display.setFixedHeight(70)
        self.display.setAlignment(Qt.AlignmentFlag.AlignRight)
        self.display.setReadOnly(True)
        self.gridLayout.addWidget(self.display, 0, 0, 1, 4)

        # Кнопки и их позиции в сетке
        buttons = {
            '7': (1, 0, '#4a4a4a'), '8': (1, 1, '#4a4a4a'), '9': (1, 2, '#4a4a4a'), '/': (1, 3, '#ff9500'),
            '4': (2, 0, '#4a4a4a'), '5': (2, 1, '#4a4a4a'), '6': (2, 2, '#4a4a4a'), '*': (2, 3, '#ff9500'),
            '1': (3, 0, '#4a4a4a'), '2': (3, 1, '#4a4a4a'), '3': (3, 2, '#4a4a4a'), '-': (3, 3, '#ff9500'),
            '0': (4, 0, '#4a4a4a'), '.': (4, 1, '#4a4a4a'), '=': (4, 2, '#ff9500'), '+': (4, 3, '#ff9500'),
            'C': (5, 0, '#ff3b30', 1, 2),
        }

        # Создаем и добавляем кнопки на калькулятор
        for btnText, data in buttons.items():
            button = QPushButton(btnText)
            button.setFixedSize(70, 70)
            button.clicked.connect(self.buttonClicked)
            
            # Установка стилей для разных типов кнопок
            if len(data) > 3:  # Для кнопки C
                color = data[2]
                self.gridLayout.addWidget(button, data[0], data[1], data[3], data[4])
            else:
                color = data[2]
                self.gridLayout.addWidget(button, data[0], data[1])
            
            button.setStyleSheet(f"""
                QPushButton {{
                    background-color: {color};
                    color: white;
                    border: none;
                    border-radius: 35px;
                }}
                QPushButton:hover {{
                    background-color: {self.lighten_color(color)};
                }}
                QPushButton:pressed {{
                    background-color: {self.darken_color(color)};
                }}
            """)

        self.current_operation = ''
        self.first_number = None
        self.new_number = True

    @staticmethod
    def lighten_color(color):
        if color.startswith('#'):
            color = color[1:]
        rgb = tuple(int(color[i:i+2], 16) for i in (0, 2, 4))
        rgb = tuple(min(255, c + 20) for c in rgb)
        return f'#{rgb[0]:02x}{rgb[1]:02x}{rgb[2]:02x}'

    @staticmethod
    def darken_color(color):
        if color.startswith('#'):
            color = color[1:]
        rgb = tuple(int(color[i:i+2], 16) for i in (0, 2, 4))
        rgb = tuple(max(0, c - 20) for c in rgb)
        return f'#{rgb[0]:02x}{rgb[1]:02x}{rgb[2]:02x}'

    def buttonClicked(self):
        button = self.sender()
        text = button.text()

        if text.isdigit() or text == '.':
            self.handleNumber(text)
        elif text in ['+', '-', '*', '/']:
            self.handleOperation(text)
        elif text == '=':
            self.calculateResult()
        elif text == 'C':
            self.clearDisplay()

    def handleNumber(self, text):
        if self.new_number:
            self.display.clear()
            self.new_number = False
        
        current = self.display.text()
        if text == '.' and '.' in current:
            return
        
        self.display.setText(current + text)

    def handleOperation(self, op):
        try:
            self.first_number = float(self.display.text())
            self.current_operation = op
            self.new_number = True
        except ValueError:
            self.display.setText('Error')
            self.new_number = True

    def calculateResult(self):
        if self.current_operation and self.first_number is not None:
            try:
                second_number = float(self.display.text())
                
                if self.current_operation == '+':
                    result = self.first_number + second_number
                elif self.current_operation == '-':
                    result = self.first_number - second_number
                elif self.current_operation == '*':
                    result = self.first_number * second_number
                elif self.current_operation == '/':
                    if second_number == 0:
                        self.display.setText('Error')
                        return
                    result = self.first_number / second_number
                
                if result.is_integer():
                    self.display.setText(str(int(result)))
                else:
                    self.display.setText(f"{result:.8f}".rstrip('0').rstrip('.'))
                
                self.first_number = None
                self.current_operation = ''
                self.new_number = True
            
            except ValueError:
                self.display.setText('Error')
                self.new_number = True

    def clearDisplay(self):
        self.display.clear()
        self.first_number = None
        self.current_operation = ''
        self.new_number = True

if __name__ == '__main__':
    app = QApplication(sys.argv)
    calc = Calculator()
    calc.show()
    sys.exit(app.exec())
