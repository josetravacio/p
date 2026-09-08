FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    sqlite3 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN corepack enable

COPY . .

RUN pnpm install && pnpm -r --if-present build

ENV OPENCLAW_DISABLED_PLUGINS="browser,canvas,cua-computer,google-meet,teams-meetings,zoom-meetings"
ENV NODE_OPTIONS="--max-old-space-size=350"
ENV NODE_ENV="production"
ENV PORT=8080

EXPOSE 8080

CMD ["pnpm", "start"]
