============
Приложение Клиент-Сервер на Go и Python
============

Описание
--------

Простое приложение клиент-сервер, где сервер написан на Go, а клиент на Python. Сервер прослушивает входящие соединения и печатает полученные сообщения. Клиент периодически подключается к серверу и отправляет несколько сообщений.

Приложение состоит из двух основных компонентов:

* **Сервер (Go):**  TCP-сервер, прослушивает порт 5000 и обрабатывает входящие соединения. Он принимает сообщения от клиента и выводит их на консоль.

* **Клиент (Python):** Клиент, написан на Python,  подключается к серверу Go и отправляет ему сообщения. После отправки серии сообщений, клиент закрывает соединение и через некоторое время снова подключается.

Клиент и сервер упакованы в докер контейнеры.
