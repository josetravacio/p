FROM node:20-alpine
WORKDIR /app
RUN apk add --no-cache git
RUN git clone https://github.com/openclaw/openclaw.git .
RUN npm ci --only=production
ENV PORT=8080
EXPOSE 8080
CMD ["npm", "start"]
