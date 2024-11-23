# tests/test_button_clicks.py
import pytest
from PyQt6.QtWidgets import QPushButton

class TestCalculatorButtonClicks:
    @pytest.mark.parametrize("digits,expected", [
        ('123', '123'),
        ('0', '0'),
        ('9876543210', '9876543210'),
        ('0000', '0000'),
    ])
    def test_number_button_clicks(self, calculator, digits, expected):
        """Тест нажатия цифровых кнопок"""
        for digit in digits:
            self.find_button(calculator, digit).click()
        assert calculator.display.text() == expected

    @pytest.mark.parametrize("first,operation,second,expected", [
        ('2', '+', '2', '4'),
        ('5', '-', '3', '2'),
        ('4', '*', '3', '12'),
        ('10', '/', '2', '5'),
        ('8', '+', '0', '8'),
        ('6', '*', '1', '6'),
    ])
    def test_operation_button_clicks(self, calculator, first, operation, second, expected):
        """Тест базовых операций через нажатие кнопок"""
        for digit in first:
            self.find_button(calculator, digit).click()
        self.find_button(calculator, operation).click()
        for digit in second:
            self.find_button(calculator, digit).click()
        self.find_button(calculator, '=').click()
        
        assert calculator.display.text() == expected

    @pytest.mark.parametrize("input_sequence,expected", [
        (['1', '2', '3', 'C'], ''),
        (['5', '5', '5', 'C'], ''),
        (['1', '+', '1', 'C'], ''),
    ])
    def test_clear_button_click(self, calculator, input_sequence, expected):
        """Тест кнопки очистки"""
        for button in input_sequence:
            self.find_button(calculator, button).click()
        assert calculator.display.text() == expected

    @pytest.mark.parametrize("input_sequence,expected", [
        (['1', '.', '5'], '1.5'),
        (['0', '.', '0'], '0.0'),
        (['1', '.', '.', '5'], '1.5'),
        (['1', '.', '5', '.', '2'], '1.52'),
    ])
    def test_decimal_input(self, calculator, input_sequence, expected):
        """Тест ввода десятичных чисел"""
        for button in input_sequence:
            self.find_button(calculator, button).click()
        assert calculator.display.text() == expected

    @pytest.mark.parametrize("input_sequence,expected", [
        (['2', '+', '3', '=', '*', '4', '='], '20'),
        (['5', '*', '2', '=', '+', '3', '='], '13'),
        (['9', '-', '4', '=', '/', '5', '='], '1'),
    ])
    def test_complex_calculations(self, calculator, input_sequence, expected):
        """Тест сложных последовательностей вычислений"""
        for button in input_sequence:
            self.find_button(calculator, button).click()
        assert calculator.display.text() == expected

    @pytest.mark.parametrize("input_sequence,expected", [
        (['+', '='], 'Error'),
        (['*', '='], 'Error'),
        (['1', '/', '0', '='], 'Error'),
        (['/'], 'Error'),
    ])
    def test_invalid_operations(self, calculator, input_sequence, expected):
        """Тест некорректных операций"""
        for button in input_sequence:
            self.find_button(calculator, button).click()
        assert calculator.display.text() == expected

    @staticmethod
    def find_button(calculator, text):
        """Вспомогательный метод для поиска кнопки по тексту"""
        for child in calculator.findChildren(QPushButton):
            if child.text() == text:
                return child
        raise ValueError(f"Button with text '{text}' not found")

    @pytest.mark.parametrize("first_op,second_op,expected", [
        (('+', '5'), ('+', '3'), '10'),  # 2 + 5 = 7, 7 + 3 = 10
        (('-', '3'), ('*', '2'), '-2'),  # 2 - 3 = -1, -1 * 2 = -2
        (('*', '2'), ('/', '4'), '1'),   # 2 * 2 = 4, 4 / 4 = 1
    ])

    def test_consecutive_operations(self, calculator, first_op, second_op, expected):
        """Тест последовательных операций"""
        # Начинаем с 2
        self.find_button(calculator, '2').click()
    
        # Первая операция
        self.find_button(calculator, first_op[0]).click()
        self.find_button(calculator, first_op[1]).click()
        self.find_button(calculator, '=').click()
    
     # Вторая операция
        self.find_button(calculator, second_op[0]).click()
        self.find_button(calculator, second_op[1]).click()
        self.find_button(calculator, '=').click()
    
        assert calculator.display.text() == expected

