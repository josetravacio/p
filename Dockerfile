FROM node:24-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    sqlite3 \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/openclaw/openclaw.git .

RUN corepack enable

ENV NODE_OPTIONS="--max-old-space-size=4096"
ENV OPENCLAW_TSDOWN_MAX_OLD_SPACE_MB=3072

RUN pnpm install && pnpm run --if-present build

ENV OPENCLAW_DISABLED_PLUGINS="browser,canvas,cua-computer,google-meet,teams-meetings,zoom-meetings"
ENV NODE_ENV="production"
ENV PORT=8080

EXPOSE 8080

CMD ["pnpm", "start"]
