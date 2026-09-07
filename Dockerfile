FROM node:24-alpine
WORKDIR /app
RUN apk add --no-cache git
RUN git clone --depth 1 https://github.com/openclaw/openclaw.git .
ENV NODE_OPTIONS="--max-old-space-size=4096"
ENV OPENCLAW_TSDOWN_MAX_OLD_SPACE_MB=4096
RUN corepack enable && pnpm install && pnpm build
ENV PORT=8080
EXPOSE 8080
CMD ["node", "openclaw.mjs", "onboard", "--non-interactive", "--accept-risk"]
