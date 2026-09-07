FROM node:20-alpine
WORKDIR /app
RUN apk add --no-cache git
RUN git clone --depth 1 -b v2 https://github.com/openclaw/openclaw.git .
RUN npm install --omit=dev
ENV PORT=8080
EXPOSE 8080
CMD ["npm", "start"]
