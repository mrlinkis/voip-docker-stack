#!/bin/bash

# Запускать от пользователя с правами на docker
# Перед запуском - настрой ts.yaml и cdrsender.ini

echo "🚀 Запуск развёртывания VoIP-стека..."

cd /home/editor/voip-docker || { echo "❌ Папка voip-docker не найдена"; exit 1; }

# 1. Загружаем готовый образ CDR
echo "📦 Загружаем образ CDRSender..."
docker load -i CDRs/cdr_sender.img || { echo "❌ Ошибка загрузки образа"; exit 1; }

# 2. Собираем контейнеры FreeSwitch и telservice
echo "🔨 Собираем FreeSwitch и telservice..."
docker-compose build || { echo "❌ Ошибка сборки"; exit 1; }

# 3. Запускаем всё
echo "🚀 Запускаем контейнеры..."
docker-compose up -d || { echo "❌ Ошибка запуска"; exit 1; }

# 4. Проверяем статус
echo "✅ VoIP-стек запущен. Проверка статуса..."
docker ps -a

echo ""
echo "📌 Теперь нужно:"
echo "1. Настроить ~/voip-docker/telephony_service/config/ts.yaml"
echo "2. Настроить ~/voip-docker/cdr_sender/config/cdrsender.ini"
echo "3. Перезапустить сервисы: docker-compose restart telservice cdrsender"

echo "🎉 Готово. Можешь звонить."
