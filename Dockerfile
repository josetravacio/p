FROM node:24-alpine
WORKDIR /app
RUN apk add --no-cache git
RUN git clone --depth 1 https://github.com/openclaw/openclaw.git .

ENV NODE_OPTIONS="--max-old-space-size=4096"
ENV OPENCLAW_TSDOWN_MAX_OLD_SPACE_MB=4096
ENV HOST=0.0.0.0
ENV PORT=8080
ENV GATEWAY_TOKEN="clave_secreta_openclaw_2026"
ENV OPENCLAW_GATEWAY_TOKEN="clave_secreta_openclaw_2026"

RUN corepack enable && pnpm install && pnpm build

EXPOSE 8080
CMD ["sh", "-c", "NODE_OPTIONS='--max-old-space-size=384' node openclaw.mjs onboard --non-interactive --accept-risk --skip-health && node openclaw.mjs config set gateway.controlUi.allowedOrigins '[\"https://openclaw-app-jpoh.onrender.com\", \"http://localhost:8080\"]' && NODE_OPTIONS='--max-old-space-size=384' node openclaw.mjs gateway run --port ${PORT:-8080} --bind lan --allow-unconfigured --token \"${GATEWAY_TOKEN}\""]
