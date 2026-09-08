FROM node:24-alpine
WORKDIR /app
RUN apk add --no-cache git
RUN git clone --depth 1 https://github.com/openclaw/openclaw.git .

ENV NODE_OPTIONS="--max-old-space-size=512"
ENV OPENCLAW_ALLOW_UNAUTHENTICATED=true

RUN corepack enable && pnpm install && pnpm build

EXPOSE 8080
CMD ["sh", "-c", "node openclaw.mjs gateway run --port ${PORT:-8080} --bind lan --allow-unconfigured"]
