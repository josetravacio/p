FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    sqlite3 \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/openclaw/openclaw.git .

RUN corepack enable

RUN pnpm install && pnpm run --if-present build

ENV OPENCLAW_DISABLED_PLUGINS="browser,canvas,cua-computer,google-meet,teams-meetings,zoom-meetings"
ENV NODE_OPTIONS="--max-old-space-size=350"
ENV NODE_ENV="production"
ENV PORT=8080

EXPOSE 8080

CMD ["pnpm", "start"]
