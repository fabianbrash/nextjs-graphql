FROM node:14.15.1-alpine3.12 as build
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm ci --silent
# RUN npm install --production --silent && mv node_modules ../
COPY . .
RUN npm run build

FROM node:14.15.1-alpine3.12
LABEL maintainer="Fabian Brash"
COPY --from=build /usr/src/app/out/ /opt/app
RUN npm install -g serve --silent
WORKDIR /opt/app
USER 1000
EXPOSE 5000
CMD ["serve", "-s"]
