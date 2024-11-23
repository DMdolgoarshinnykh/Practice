import pytest
from PyQt6.QtWidgets import QPushButton, QLineEdit
from PyQt6.QtCore import Qt

class TestCalculatorUI:
    def test_window_title(self, calculator):
        """Проверка заголовка окна"""
        assert calculator.windowTitle() == "Калькулятор"

    def test_window_size(self, calculator):
        """Проверка размера окна"""
        assert calculator.size().width() == 350
        assert calculator.size().height() == 500

    def test_display_properties(self, calculator):
        """Проверка свойств дисплея"""
        display = calculator.display
        assert isinstance(display, QLineEdit)
        assert display.isReadOnly()
        assert display.alignment() == Qt.AlignmentFlag.AlignRight

    def test_buttons_exist(self, calculator):
        """Проверка наличия всех кнопок"""
        expected_buttons = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                          '+', '-', '*', '/', '=', 'C', '.']
        buttons = calculator.findChildren(QPushButton)
        button_texts = [b.text() for b in buttons]
        for expected in expected_buttons:
            assert expected in button_texts

    def test_button_sizes(self, calculator):
        """Проверка размеров кнопок"""
        buttons = calculator.findChildren(QPushButton)
        for button in buttons:
            if button.text() != 'C':  # Кнопка C имеет другой размер
                assert button.size().width() == 70
                assert button.size().height() == 70

    def test_button_styles(self, calculator):
        """Проверка стилей кнопок"""
        for button in calculator.findChildren(QPushButton):
            assert 'QPushButton' in button.styleSheet()
            assert 'background-color' in button.styleSheet()

    def test_display_initial_state(self, calculator):
        """Проверка начального состояния дисплея"""
        assert calculator.display.text() == ''
        assert calculator.new_number == True
