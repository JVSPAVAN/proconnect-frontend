# Stage 1
FROM node:latest as node

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm cache clean --force

RUN npm i npm@latest -g

RUN npm install --legacy-peer-deps

COPY . .

RUN npm run build

# Stage 2
FROM nginx:alpine

COPY --from=node /usr/src/app/dist /usr/share/nginx/html

COPY --from=node /nginx.conf /etc/nginx/conf.d/default.conf