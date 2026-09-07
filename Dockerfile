FROM node:24-alpine
WORKDIR /app
RUN apk add --no-cache git
RUN git clone --depth 1 https://github.com/openclaw/openclaw.git .
RUN corepack enable && pnpm install --prod
ENV PORT=8080
EXPOSE 8080
CMD ["pnpm", "start"]
