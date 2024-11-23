import pytest
from PyQt6.QtWidgets import QApplication
from calculator import Calculator

@pytest.fixture(scope="session")
def app():
    """Создает экземпляр QApplication для всей тестовой сессии"""
    app = QApplication([])
    yield app
    app.quit()

@pytest.fixture
def calculator(app):
    """Создает новый экземпляр калькулятора для каждого теста"""
    calc = Calculator()
    return calc
