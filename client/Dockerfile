FROM node:alpine as builder
WORKDIR '/app'
COPY ./package.json ./

#resolution configurations
RUN npm install npm-force-resolutions
RUN npm install
RUN npx npm-force-resolutions
RUN npm install

COPY . .
RUN npm run build

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
