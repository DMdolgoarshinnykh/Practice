# tests/test_integration.py
import pytest
from PyQt6.QtWidgets import QPushButton
from PyQt6.QtCore import Qt

class TestCalculatorIntegration:
    def test_basic_operation_chain(self, calculator):
        """Тест цепочки базовых операций"""
        # 2 + 3 * 4 = 12 (операции выполняются последовательно, без приоритета)
        sequence = ['2', '+', '3', '=', '*', '4', '=']
        for button in sequence:
            self.find_button(calculator, button).click()
        assert calculator.display.text() == '20'  # (2 + 3) * 4 = 20

    def test_multiple_operations(self, calculator):
        """Тест множественных операций"""
        # 5 + 5 = 10, затем * 2 = 20
        sequence = ['5', '+', '5', '=', '*', '2', '=']
        for button in sequence:
            self.find_button(calculator, button).click()
        assert calculator.display.text() == '20'

    def test_decimal_operations(self, calculator):
        """Тест операций с десятичными числами"""
        sequence = ['1', '.', '5', '+', '2', '.', '5', '=']
        for button in sequence:
            self.find_button(calculator, button).click()
        assert calculator.display.text() == '4'

    def test_clear_between_operations(self, calculator):
        """Тест очистки между операциями"""
        sequence = ['1', '+', '1', '=', 'C', '2', '*', '2', '=']
        for button in sequence:
            self.find_button(calculator, button).click()
        assert calculator.display.text() == '4'

    @staticmethod
    def find_button(calculator, text):
        """Поиск кнопки по тексту"""
        for child in calculator.findChildren(QPushButton):
            if child.text() == text:
                return child
        raise ValueError(f"Button with text '{text}' not found")
