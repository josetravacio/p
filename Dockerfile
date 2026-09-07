FROM node:24-alpine
WORKDIR /app
RUN apk add --no-cache git
RUN git clone --depth 1 https://github.com/openclaw/openclaw.git .

ENV NODE_OPTIONS="--max-old-space-size=4096"
ENV HOST=0.0.0.0
ENV PORT=8080
ENV GATEWAY_TOKEN="clave_secreta_openclaw_2026"

RUN corepack enable && pnpm install && pnpm build

EXPOSE 8080
CMD ["sh", "-c", "NODE_OPTIONS='--max-old-space-size=384' node openclaw.mjs onboard --non-interactive --accept-risk --skip-health && node openclaw.mjs config set gateway.trustedProxies '[\"127.0.0.1\", \"10.0.0.0/8\", \"172.16.0.0/12\"]' && node openclaw.mjs config set gateway.controlUi.allowedOrigins '[\"https://openclaw-app-jpoh.onrender.com\"]' && node openclaw.mjs config set gateway.auth.token \"${GATEWAY_TOKEN}\" && (sleep 8 && node openclaw.mjs gateway approve 01516c42-9d8c-4faf-a5ac-cbe66f5f6f1b 2>/dev/null) & NODE_OPTIONS='--max-old-space-size=384' node openclaw.mjs gateway run --port ${PORT:-8080} --bind lan"]
