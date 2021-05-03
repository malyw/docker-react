# FROM node:alpine as builder
FROM node:alpine
WORKDIR '/app'
COPY package.json .
COPY package-lock.json .
RUN npm ci
COPY . .
RUN npm run build

FROM nginx
# for AWS ElasticBeanStalk
EXPOSE 80
#COPY --from=builder /app/build /usr/share/nginx/html
# copy the folder from the prev build
COPY --from=0 /app/build /usr/share/nginx/html