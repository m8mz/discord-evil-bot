FROM node:22-slim
WORKDIR /app

COPY package*.json pnpm-lock.yaml* ./
RUN corepack enable && pnpm install --frozen-lockfile --prod

COPY ./src/ .

USER node

ENV NODE_ENV=production
CMD ["node", "index.js"]
