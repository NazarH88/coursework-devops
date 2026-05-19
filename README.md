# DevOps Coursework — Flask CI/CD Demo 🚀

## Опис проєкту

Цей проєкт створений у межах курсової роботи з дисципліни DevOps та демонструє повний процес автоматизованого розгортання веб-застосунку.

У проєкті реалізовано:

- Flask веб-застосунок
- Docker контейнеризацію
- reverse proxy через Nginx
- CI/CD pipeline у Jenkins
- автоматичне тестування
- health-check контейнерів
- автоматичний deploy через Docker Compose

---

# Використані технології

| Технологія | Призначення |
|---|---|
| Python 3.12 | Основна мова програмування |
| Flask | Backend веб-застосунок |
| Gunicorn | Production WSGI сервер |
| Docker | Контейнеризація |
| Docker Compose | Оркестрація контейнерів |
| Nginx | Reverse proxy |
| Jenkins | CI/CD автоматизація |
| GitHub | Зберігання коду |

---

# Архітектура проєкту

```text
Client Browser
       │
       ▼
    Nginx
       │
       ▼
 Flask + Gunicorn
       │
       ▼
 Docker Container
```

---

# Структура проєкту

```text
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
├── docker-compose.yml
├── Jenkinsfile
└── README.md
```

---

# Основний функціонал

## Flask API endpoints

### Головна сторінка

```http
GET /
```

Відображає frontend сторінку застосунку.

---

### Health-check endpoint

```http
GET /api/health
```

Використовується для:
- Jenkins pipeline
- Docker healthcheck
- перевірки працездатності сервісу

Приклад відповіді:

```json
{
  "status": "ok",
  "environment": "production",
  "version": "1.0.0"
}
```

---

### Інформація про застосунок

```http
GET /api/info
```

Повертає:
- версію
- environment
- hostname контейнера
- runtime інформацію

---

# Docker

## Build Docker image

```bash
docker build -f docker/Dockerfile -t coursework-flask-app .
```

---

## Запуск контейнера

```bash
docker run -p 5000:5000 coursework-flask-app
```

Застосунок буде доступний:

```text
http://localhost:5000
```

---

# Docker Compose

## Запуск усіх сервісів

```bash
docker compose up -d --build
```

---

## Зупинка контейнерів

```bash
docker compose down
```

---

## Перегляд контейнерів

```bash
docker ps
```

---

## Перегляд логів

```bash
docker compose logs
```

---

# Jenkins CI/CD Pipeline

Pipeline автоматично виконує:

1. Checkout репозиторію
2. Build Docker image
3. Test application
4. Health-check verification
5. Deploy через Docker Compose
6. Final verification

---

## Jenkins stages

| Stage | Опис |
|---|---|
| Checkout | Клонування репозиторію |
| Build | Збірка Docker image |
| Test | Перевірка health endpoint |
| Deploy | Розгортання контейнерів |
| Verify | Перевірка доступності сервісу |

---

# Reverse Proxy (Nginx)

Nginx використовується як reverse proxy між користувачем та Flask застосунком.

Конфігурація:

```text
docker/nginx.conf
```

Nginx:
- приймає HTTP requests
- проксіює запити до Flask
- ізолює backend
- забезпечує стабільну роботу сервісу

---

# Health Monitoring

Docker автоматично перевіряє стан контейнера через:

```http
/api/health
```

При помилці контейнер може бути автоматично перезапущений.

---

# Корисні команди

## Перебілдити проєкт

```bash
docker compose up -d --build
```

---

## Видалити старі контейнери

```bash
docker compose down
```

---

## Подивитись логи Flask

```bash
docker logs flask_app
```

---

## Подивитись логи Nginx

```bash
docker logs nginx_proxy
```

---

## Перевірити health endpoint

```bash
curl http://localhost/api/health
```

---

## Перевірити Jenkins статус

```bash
systemctl status jenkins
```

---

## Перезапустити Jenkins

```bash
sudo systemctl restart jenkins
```

---

# Git команди

## Отримати зміни

```bash
git pull origin main
```

---

## Відправити зміни

```bash
git add .
git commit -m "update project"
git push origin main
```

---

# Результат роботи

Після успішного запуску:

- Flask застосунок працює у Docker
- Nginx виконує reverse proxy
- Jenkins автоматично деплоїть зміни
- health-check успішно проходить
- CI/CD pipeline працює повністю автоматизовано

---

# Автор

Курсова робота з DevOps автоматизації та контейнеризації.

GitHub repository:

:contentReference[oaicite:0]{index=0}

---

# License

Educational project for DevOps learning purposes.
