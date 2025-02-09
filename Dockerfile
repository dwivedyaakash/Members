FROM node:15 as development
LABEL org.opencontainers.image.source https://github.com/eddiehubcommunity/LinkFree

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install --ignore-scripts
COPY . .

RUN npm run build

FROM node:15 as production
LABEL org.opencontainers.image.source https://github.com/eddiehubcommunity/LinkFree

ARG NODE_ENV=production

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install --production --ignore-scripts
COPY . .
COPY --from=development /usr/src/app/build ./build
CMD ["npm", "run", "start:prod"]
