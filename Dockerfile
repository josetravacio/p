FROM node:24-alpine
WORKDIR /app
RUN apk add --no-cache git
RUN git clone --depth 1 https://github.com/openclaw/openclaw.git .

ENV OPENCLAW_ALLOW_UNAUTHENTICATED=true
ENV OPENCLAW_TSDOWN_MAX_OLD_SPACE_MB=4096
ENV NODE_OPTIONS="--max-old-space-size=4096"

RUN corepack enable && pnpm install && pnpm build

ENV NODE_OPTIONS="--max-old-space-size=384"
EXPOSE 8080
CMD ["node", "openclaw.mjs", "gateway", "run", "--port", "8080", "--bind", "lan", "--allow-unconfigured"]
