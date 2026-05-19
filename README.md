# DevOps Coursework — Flask + Docker + Nginx + Jenkins

Веб-додаток на Flask із контейнеризацією (Docker), reverse proxy (Nginx) та CI/CD пайплайном (Jenkins).

## Структура репозиторію

```
coursework-devops/
│
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── templates/
│       └── index.html
│
├── docker/
│   ├── Dockerfile
│   └── nginx.conf
│
├── Jenkinsfile
└── docker-compose.yml
```

## Швидкий старт (без Jenkins)

```bash
# 1. Клонувати репозиторій
git clone <URL_РЕПОЗИТОРІЮ>
cd coursework-devops

# 2. Підняти всі сервіси
docker compose up -d --build

# 3. Відкрити у браузері
# http://localhost
```

## Endpoints

| Метод | URL | Опис |
|-------|-----|------|
| GET | `/` | Головна сторінка |
| GET | `/api/health` | Health-check (JSON) |
| GET | `/api/info` | Інфо про додаток (JSON) |

## Налаштування Jenkins

### Вимоги
- Jenkins встановлений та запущений
- Плагіни: Git, Pipeline, Docker Pipeline

### Кроки
1. Jenkins → **New Item** → **Pipeline** → назвати `coursework-devops`
2. У секції **Pipeline** обрати **Pipeline script from SCM**
3. SCM: **Git**, вказати URL репозиторію
4. Script Path: `jenkins/Jenkinsfile`
5. Зберегти та натиснути **Build Now**

## Корисні команди

```bash
# Статус контейнерів
docker compose ps

# Логи Flask
docker compose logs app

# Логи Nginx
docker compose logs nginx

# Зупинити всі сервіси
docker compose down

# Перезібрати образ
docker compose up -d --build
```
