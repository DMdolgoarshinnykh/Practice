# tests/test_exceptions.py
import pytest
from PyQt6.QtWidgets import QPushButton

class TestCalculatorExceptions:
    def test_division_by_zero(self, calculator):
        """Тест деления на ноль"""
        sequence = ['1', '/', '0', '=']
        for button in sequence:
            self.find_button(calculator, button).click()
        assert calculator.display.text() == 'Error'

    def test_invalid_operation_sequence(self, calculator):
        """Тест недопустимой последовательности операций"""
        test_cases = [
            (['/', '='], 'Error'),
            (['*', '='], 'Error'),
            (['+', '='], 'Error'),
            (['-', '='], 'Error'),
            (['='], '')
        ]
        for sequence, expected in test_cases:
            calculator.clearDisplay()
            for button in sequence:
                self.find_button(calculator, button).click()
            assert calculator.display.text() == expected

    def test_large_numbers(self, calculator):
        """Тест работы с большими числами"""
        # 999999 * 999999
        sequence = ['9', '9', '9', '9', '9', '9', '*', 
                   '9', '9', '9', '9', '9', '9', '=']
        for button in sequence:
            self.find_button(calculator, button).click()
        # Проверяем, что результат - число
        result = calculator.display.text()
        assert result.isdigit()
        assert len(result) > 10  # Проверяем, что это действительно большое число

    def test_decimal_point_handling(self, calculator):
        """Тест обработки десятичной точки"""
        test_cases = [
            # Проверка одиночной точки
            (['.'], '.'),
            # Проверка множественных точек
            (['1', '.', '.'], '1.'),
            # Проверка точки после числа
            (['1', '2', '.'], '12.'),
            # Проверка числа после точки
            (['1', '.', '5'], '1.5')
        ]
        
        for sequence, expected in test_cases:
            calculator.clearDisplay()
            for button in sequence:
                self.find_button(calculator, button).click()
            assert calculator.display.text() == expected

    def test_leading_zeros(self, calculator):
        """Тест ведущих нулей"""
        test_cases = [
            (['0', '0', '1'], '001'),  # Калькулятор сохраняет ведущие нули
            (['0', '0', '.', '1'], '00.1'),
            (['0', '1'], '01'),
            (['0', '0', '0'], '000')
        ]
        
        for sequence, expected in test_cases:
            calculator.clearDisplay()
            for button in sequence:
                self.find_button(calculator, button).click()
            assert calculator.display.text() == expected

    @staticmethod
    def find_button(calculator, text):
        """Поиск кнопки по тексту"""
        for child in calculator.findChildren(QPushButton):
            if child.text() == text:
                return child
        raise ValueError(f"Button with text '{text}' not found")
