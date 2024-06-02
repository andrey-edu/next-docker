# Указываем базовый образ
FROM node:18.17.1-alpine

# Устанавливаем рабочий каталог
WORKDIR /app

# Install PM2 globally
RUN npm install --global pm2

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости (--production не устанавливает devDependencies)
RUN npm install

# Копируем остальные файлы
COPY . .

# Собираем приложение
RUN npm run build

# Указываем, на каком порту будет работать приложение
EXPOSE 3000

# Run container as non-root (unprivileged) user
# The node user is provided in the Node.js Alpine base image
USER node

# Указываем команду запуска (npm run start)
# CMD ["npm", "start"]

# Run npm start script with PM2 when container starts
CMD [ "pm2-runtime", "npm", "--", "start" ]
