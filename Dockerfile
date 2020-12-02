FROM node:14.15.1-alpine3.12
LABEL maintainer="Fabian Brash"
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm ci --silent
# RUN npm install --production --silent && mv node_modules ../
RUN npm install -g serve --silent
COPY . .
RUN npm run build
USER 1000
EXPOSE 5000
CMD ["serve", "-s", "out"]
