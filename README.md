# Simply Notice App

**Simply Notice App** — мобильное приложение, разработанное в рамках магистратерской диссертации на программе "Продуктовый подход и аналитика данных в HR-менеджменте" ФКН НИУ ВШЭ.

Цель приложения — помочь пользователю замечать ранние изменения состояния на основе данных сна, физической активности и коротких ежедневных самоотчетов.

Приложение не является медицинским или диагностическим инструментом, не ставит диагнозы и не заменяет консультацию специалиста.

---

## 1. Идея проекта

Приложение отслеживает динамику состояния пользователя через несколько групп показателей:

- сон;
- физическая активность;
- стресс;
- энергия;
- истощение;
- связь с людьми / социальная поддержка.

Ключевая логика продукта строится не только на абсолютных значениях, но и на сравнении текущих данных с личной нормой пользователя.

Такой подход позволяет мягко подсвечивать неблагоприятную динамику до того, как состояние станет выраженно критичным.

---

## 2. Основные пользовательские сценарии

В MVP реализованы следующие сценарии:

1. Регистрация и вход пользователя.
2. Онбординг.
3. Подключение Apple Health.
4. Получение данных о сне и активности.
5. Ежедневный чек-ин пользователя.
6. Расчёт и отображение состояния.
7. Просмотр детализации по отдельным показателям.
8. Просмотр рекомендаций.
9. Отправка обратной связи / сообщения о проблеме.

В MVP подготовлен следующий сценарий:
1. Интеграция push-уведомлений.

---

## 3. Технологический стек

Проект собран на основе FlutterFlow-generated Flutter project с последующими кастомными изменениями в коде.

Используются:

- Flutter / Dart;
- FlutterFlow;
- Firebase Authentication;
- Cloud Firestore;
- Firebase Cloud Functions;
- Firebase Cloud Messaging;
- Apple Health / HealthKit;
- Xcode для iOS-сборки;
- GitHub для хранения исходного кода.

---

## 4. Структура проекта

Основные папки:

```text
assets/      — изображения, иконки, шрифты и другие ресурсы
firebase/    — Firebase config, Firestore rules, Cloud Functions
ios/         — iOS-проект, настройки Xcode, Info.plist, entitlements
lib/         — основной Flutter/Dart-код приложения
test/        — тестовая папка Flutter
web/         — web-часть Flutter-проекта
```

Ключевые файлы:

```text
pubspec.yaml                         — зависимости Flutter-проекта
lib/main.dart                        — точка входа приложения
lib/pages/                           — экраны приложения
lib/custom_code/widgets/             — кастомные Flutter-виджеты
lib/backend/schema/                  — Firestore-схемы
firebase/functions/index.js          — Cloud Functions
firebase/firestore.rules             — Firestore Security Rules
ios/Runner/Info.plist                — iOS permissions/config
ios/Runner/Runner.entitlements       — iOS capabilities/entitlements
ios/Runner/GoogleService-Info.plist  — Firebase iOS config
```

---

## 5. Реализованные экраны

В проекте есть следующие основные страницы:

- Welcome / onboarding;
- регистрация;
- вход;
- главный экран;
- самоотчет;
- аналитика;
- профиль;
- подключение / отключение Apple Health;
- страницы детализации показателей:
  - сон;
  - шаги;
  - стресс;
  - энергия;
  - истощение;
  - связь с людьми;
- страница рекомендаций;
- страница обратной связи;

---

## 6. Apple Health / HealthKit

В приложении подготовлена интеграция с Apple Health / HealthKit.

Используемые данные:

- сон;
- шаги / физическая активность.

Для работы HealthKit требуется:

1. физический iPhone;
2. Apple Health на устройстве;
3. разрешение пользователя на чтение данных;
4. корректные iOS permissions;
5. сборка приложения через Xcode / Flutter на iOS-устройство.

Важно: HealthKit не работает полноценно на web и не предназначен для проверки через обычный браузер.

---

## 7. Push-уведомления

В проекте подготовлена архитектура push-уведомлений через Firebase Cloud Messaging.

Предусмотрены два основных сценария уведомлений:

1. **Ежедневное напоминание о самоотчете**  
   Например, в 19:00 пользователь получает напоминание пройти короткий самоотчет.

2. **Сигнал при неблагоприятной динамике состояния**  
   Например, если состояние несколько дней подряд находится в неблагоприятной зоне, приложение может мягко предложить пользователю обратить внимание на себя.

На текущем этапе в приложении подготовлена клиентская часть:

- запрос разрешения на уведомления;
- проверка APNs token на iOS;
- получение FCM token после появления APNs token;
- передача FCM token в backend через callable Cloud Function;
- безопасная обработка ситуации, когда APNs token отсутствует.

Если Apple Developer / APNs не настроены, приложение не падает, а выводит в логах ожидаемый статус:

```text
apns_token_missing
```

Это нормальное поведение для сборки без полноценной Apple Developer/APNs-настройки.

---

## 8. Безопасное сохранение FCM token

FCM token не сохраняется напрямую из клиентского приложения в Firestore.

Вместо этого используется Cloud Function:

```text
saveUserFcmToken
```

Схема:

```text
iPhone
→ APNs token
→ FCM token
→ callable Cloud Function saveUserFcmToken
→ Firestore user_info
```

Такой подход позволяет не ослаблять Firestore Security Rules, потому что запись выполняется на backend-стороне через Firebase Admin SDK.

Функция находится здесь:

```text
firebase/functions/index.js
```

---

## 9. Как запустить проект локально

### 9.1. Клонировать репозиторий

```bash
git clone https://github.com/olchia/simply_notice_app.git
cd simply_notice_app
```

### 9.2. Установить Flutter-зависимости

```bash
flutter pub get
```

### 9.3. Установить iOS Pods

```bash
cd ios
pod install
cd ..
```

### 9.4. Проверить доступные устройства

```bash
flutter devices
```

### 9.5. Запустить на iPhone

```bash
flutter run -d <DEVICE_ID>
```

Для release-сборки:

```bash
flutter run -d <DEVICE_ID> --release
```

---

## 10. Firebase Functions

Cloud Functions находятся в папке:

```text
firebase/functions
```

Перед деплоем нужно установить зависимости:

```bash
cd firebase/functions
npm install
```

Деплой функции сохранения FCM token:

```bash
cd ..
firebase deploy --only functions:functions:saveUserFcmToken --project simple-notify-app-97757
```

Если используется другой Firebase project ID, нужно заменить:

```text
simple-notify-app-97757
```

на актуальный project ID.

---

## 11. Инструкция по подключению push-уведомлений на iOS

Для полноценной доставки push-уведомлений на iPhone требуется действующий Apple Developer Program.

### 11.1. Что необходимо

Нужно иметь:

- Apple Developer Program;
- Xcode;
- физический iPhone;
- Firebase iOS app configuration;
- корректный Bundle ID;
- APNs authentication key;
- загруженный APNs key в Firebase.

---

### 11.2. Настройка Xcode

Открыть iOS-проект:

```bash
open ios/Runner.xcworkspace
```

Дальше в Xcode:

```text
Runner → TARGETS → Runner → Signing & Capabilities
```

Добавить capability:

```text
Push Notifications
```

Добавить capability:

```text
Background Modes
```

Внутри Background Modes включить:

```text
Remote notifications
```

Также нужно проверить, что Bundle Identifier в Xcode совпадает с Bundle ID iOS-приложения в Firebase.

---

### 11.3. Создание APNs key в Apple Developer

В Apple Developer Console:

```text
Certificates, Identifiers & Profiles → Keys → +
```

Создать ключ с включённой возможностью:

```text
Apple Push Notifications service (APNs)
```

После создания нужно сохранить:

```text
.p8 файл
Key ID
Team ID
```

Важно: `.p8` файл обычно можно скачать только один раз.

---

### 11.4. Загрузка APNs key в Firebase

В Firebase Console:

```text
Project Settings → Cloud Messaging → Apple app configuration
```

Загрузить:

```text
APNs authentication key (.p8)
Key ID
Team ID
```

После этого Firebase сможет выдавать FCM token для iOS-устройства.

---

### 11.5. Проверка push-интеграции

После настройки Apple Developer / APNs запустить приложение на физическом iPhone:

```bash
flutter run -d <DEVICE_ID>
```

В логах должен появиться результат примерно такого вида:

```text
Push permission status: authorized
APNs token received.
FCM token received: ...
saveUserFcmToken result: ...
```

После этого в Firestore в документе пользователя в коллекции `user_info` должны появиться поля:

```text
fcm_token
fcm_tokens
fcm_platform
notifications_permission_status
notifications_enabled
checkin_reminder_enabled
checkin_reminder_time
push_setup_status
fcm_token_updated_at
```

Ожидаемый статус:

```text
push_setup_status: ready
```

---

## 12. Ограничения текущей версии

Текущий MVP подготовлен для демонстрации продуктовой и технической логики, но имеет ограничения:

- push-уведомления на iOS требуют Apple Developer Program и APNs-настройки;
- приложение не является медицинским инструментом;
- расчётные правила состояния являются MVP-логикой и могут быть уточнены в будущих версиях;
- рекомендации являются поддерживающими подсказками, а не медицинскими рекомендациями;
- для полноценной проверки Apple Health требуется физический iPhone и разрешения пользователя.

---

## 13. Безопасность и данные

В проекте используются Firebase Authentication и Firestore Security Rules.

В `.gitignore` исключены:

```text
build/
ios/Pods/
firebase/functions/node_modules/
.env
*.p8
*.key
serviceAccountKey.json
firebase-debug.log
```

Это сделано, чтобы не публиковать временные файлы, зависимости, приватные ключи и локальные логи.

В репозитории присутствует Firebase iOS config:

```text
ios/Runner/GoogleService-Info.plist
```

Этот файл нужен для сборки приложения с Firebase. Он содержит техническую конфигурацию Firebase-проекта, но не является приватным service account key.

---

## 14. Автор

Проект подготовлен в рамках магистерской диссертацией студенткой 2 курса программы "Продуктовый подход и аналитика данных в HR-менеджменте" ФКН НИУ ВШЭ.
