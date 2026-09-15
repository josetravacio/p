FROM node:24-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    sqlite3 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Instalar versión precompilada directamente desde npm
RUN npm install -g openclaw@latest

ENV OPENCLAW_DISABLED_PLUGINS="browser,canvas,cua-computer,google-meet,teams-meetings,zoom-meetings"
ENV OPENCLAW_TRUSTED_PROXIES="127.0.0.1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
ENV NODE_OPTIONS="--max-old-space-size=400"
ENV NODE_ENV="production"
ENV PORT=8080

EXPOSE 8080

CMD ["openclaw", "start"]
