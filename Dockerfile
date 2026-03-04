# syntax=docker/dockerfile:1

FROM node:22-bookworm AS dev
WORKDIR /app
COPY --chown=node:node package.json package-lock.json ./
RUN npm ci
COPY --chown=node:node src ./src
USER node
ENV NODE_ENV=development
EXPOSE 3000 9229
CMD ["npm", "run", "dev"]


FROM node:22-bookworm-slim AS prod
WORKDIR /app
COPY package.json package-lock.json ./
ENV NODE_ENV=production
RUN npm ci
COPY --chown=node:node src ./src
USER node
EXPOSE 3000
CMD ["node", "src/index.js"]
