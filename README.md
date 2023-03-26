# Мессенджер
Необходимо написать программную реализацию мессенджера. 

Приложение должно поддерживать работу со следующими данными:

* Пользователь
* Групповой чат 
* P2P (Peer-to-Peer) чат

Требуется реализовать следующий API:

* Создание нового пользователя
* Поиск пользователя по логину
* Поиск пользователя по маске имени и фамилии
* Создание группового чата
* Добавление пользователя в чат
* Добавление сообщения в групповой чат
* Загрузка сообщений группового чата
* Отправка P2P сообщения пользователю
* Получение P2P списка сообщений для пользователя

***UPD***

Для запуска микросервисов в Docker, неоходимо перейти в папаку [!Docker](https://github.com/JuliaTsiryulik/SoftwareEngineering/tree/main/Messenger/!Docker) и выполнить команду в консоли 
```
docker-compose up --build
```
Тестовые данные для загрузки в базу данных находятся в [commands.sql](https://github.com/JuliaTsiryulik/SoftwareEngineering/blob/main/Messenger/commands.sql).

Все таблицы базы данных для работы сервисов будут созданы при первом запуске сервисов.

* Сервис авторизации: [UserService](https://github.com/JuliaTsiryulik/SoftwareEngineering/tree/main/Messenger/UserService)
* Сервис групповых чатов: [GroupService](https://github.com/JuliaTsiryulik/SoftwareEngineering/tree/main/Messenger/GroupService)
* Сервис P2P чатов: [P2PService](https://github.com/JuliaTsiryulik/SoftwareEngineering/tree/main/Messenger/P2PService)
