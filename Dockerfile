# Базовый образ — официальный Playwright для Python с предустановленными браузерами
FROM mcr.microsoft.com/playwright/python:v1.47.0-noble

# Рабочая директория внутри контейнера
WORKDIR /usr/workspace

# Установка системных зависимостей (gcc нужен для сборки некоторых Python-пакетов)
RUN apt-get update && apt-get install -y gcc && rm -rf /var/lib/apt/lists/*

# Копируем requirements.txt и устанавливаем Python-зависимости
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Устанавливаем браузеры Playwright (chromium, firefox, webkit) с системными зависимостями
RUN playwright install --with-deps chromium firefox webkit

# Копируем весь проект в контейнер
COPY . .

# Переменные окружения по умолчанию
# BROWSER — какой браузер использовать (chromium, firefox, webkit)
# MARKER — pytest-маркер для фильтрации тестов (smoke, regression и т.д.)
# THREADS — количество потоков для параллельного запуска тестов
ENV BROWSER=chromium
ENV MARKER=smoke
ENV THREADS=1

# Запуск тестов: pytest выполняет тесты из папки tests/,
# --alluredir=allure-results — сохраняет сырые результаты Allure в указанную папку
CMD ["/bin/sh", "-c", "pytest tests/ --alluredir=allure-results"]
