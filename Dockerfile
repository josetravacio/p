FROM node:24-slim
WORKDIR /app
RUN apt-get update && apt-get install -y git python3 build-essential && rm -rf /var/lib/apt/lists/*
RUN git clone --depth 1 https://github.com/openclaw/openclaw.git .
RUN corepack enable && pnpm install && pnpm build

EXPOSE 8080
CMD ["sh", "-c", "node openclaw.mjs gateway run --port ${PORT:-8080} --host 0.0.0.0 --token \"$OPENCLAW_GATEWAY_TOKEN\" --allow-unconfigured"]
