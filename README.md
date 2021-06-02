# Сферический SSL-cервис

Сервис проверки состояний SSL-сертификатов.

Демо-версия: https://evo.easing.ru/

## Как всё устроено

Раз в 20 минут запускается задача `CheckAllDomainsJob`, которая для каждой записи из таблицы `domains` ставит задачу
на проверку состояния (`UpdateDomainStatusJob`).

По результатам проверки в таблице `statuses` создаётся новая или продляется (touch-ится) актуальная запись
о состоянии домена.


## Установка и запуск

Рекомендуется Ruby 3.0.1, Bundler 2.2.18 и Docker Compose 19.03.0

### 1. Клонирование репозитория
```
git clone git@github.com:easing/evotest.git
cd evotest
mv .env.example .env
```

### 2. Запуск PostgreSQL и Redis

```
docker-compose up -d
```

### 3. Первичная настройка приложения
```
bundle install

bundle exec rails db:create
bundle exec rails db:migrate
```

### 4. Запуск веб-приложения и фоновые задачи
```
foreman start
```

Сферический SSL-сервис будет доступен на http://localhost:3000/

## Тесты
```
bundle exec rails db:create RAILS_ENV=test
bundle exec rails db:test:prepare RAILS_ENV=test
bundle exec rails test
```

## Документация

Документация к API доступна на главной странице сервиса: https://evo.easing.ru/


Чтобы создать документацию разработчика:
```
bundle exec yard
```