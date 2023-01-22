FROM node:18.13.0-alpine

WORKDIR /usr/app

COPY package*.json .

RUN npm install

COPY . .

EXPOSE 3000

VOLUME [ "/usr/app/node_modules" ]

CMD [ "npm", "start" ]
