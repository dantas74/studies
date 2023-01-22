FROM node:18.13.0-alpine

WORKDIR /usr/app

COPY package*.json .

RUN npm install

COPY . .

EXPOSE 80

ENV MONGO_USERNAME=root
ENV MONGO_PASSWORD=root

VOLUME [ "/usr/app/node_modules" ]

CMD [ "npm", "start" ]
