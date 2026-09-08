FROM node:20-slim

# Dependencias de sistema básicas
RUN apt-get update && apt-get install -y --no-install-recommends \
    sqlite3 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Instalar dependencias de producción
COPY package*.json ./
RUN npm ci --omit=dev

# Copiar código fuente
COPY . .

# Variables de entorno para control de memoria en Render
ENV OPENCLAW_DISABLED_PLUGINS="browser,canvas,cua-computer,google-meet,teams-meetings,zoom-meetings"
ENV NODE_OPTIONS="--max-old-space-size=350"
ENV NODE_ENV="production"
ENV PORT=8080

EXPOSE 8080

CMD ["npm", "start"]
