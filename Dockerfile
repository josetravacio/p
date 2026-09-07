FROM node:20-slim
WORKDIR /app
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/openclaw/openclaw.git .
RUN npm install
ENV PORT=8080
EXPOSE 8080
CMD ["npm", "start"]
