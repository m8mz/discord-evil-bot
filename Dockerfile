FROM node:22-slim
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --omit=dev

COPY . .

USER node

ENV NODE_ENV=production
CMD ["node", "src/index.js"]
