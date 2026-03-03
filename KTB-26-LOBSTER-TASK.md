# KTB-26: Загрузка словаря через document в Telegram-боте

## Контекст
При отправке файла в чат бота update может приходить без `message.text`, но с `message.document`.
Сейчас это приводит к падению на десериализации (`MissingFieldException`), и нет полного конвейера импорта словаря из файла.

## Что нужно сделать

1. Обновить модели update/message:
   - `Message.text` сделать nullable: `String? = null`
   - добавить `Document` с полями:
     - `file_name`, `mime_type`, `file_id`, `file_unique_id`, `file_size`
   - добавить в `Message`: `document: Document? = null`

2. Добавить API-модели для `getFile`:
   - `GetFileResponse(ok, result?)`
   - `TelegramFile(file_id, file_unique_id, file_size, file_path)`

3. В `TelegramBotService`:
   - реализовать `getFile(fileId)` вызов `getFile` Telegram API
   - реализовать `downloadFile(filePath, fileName)` загрузку по `https://api.telegram.org/file/bot<token>/<file_path>`

4. В обработчике update (`handleUpdate`):
   - если `message.document != null`:
     - вызвать `getFile(document.fileId)`
     - распарсить `GetFileResponse`
     - при наличии `result` скачать файл

5. После скачивания файла:
   - открыть файл словаря
   - прочитать строки
   - добавить/объединить слова в словарь пользователя
   - сохранить словарь

6. Надежность:
   - не падать на некорректных строках
   - обработать HTTP-ошибки и пустые ответы
   - отправить пользователю итог импорта: прочитано / добавлено / обновлено / пропущено

7. Тесты:
   - update без `text`, но с `document`
   - парсинг `getFile` response
   - импорт/merge словаря с некорректными строками
   - `./gradlew test` должен быть зеленым

## Definition of Done
- Бот не падает на `document` update
- Файл скачивается и обрабатывается
- Словарь обновляется и сохраняется
- Пользователь получает понятный результат импорта
- Все тесты проходят
