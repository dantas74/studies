FROM node:14-alpine

ARG DEFAULT_PORT=80

WORKDIR /usr/app

COPY package.json .

RUN npm install

COPY . .

ENV PORT $DEFAULT_PORT

EXPOSE $PORT

VOLUME [ "/usr/app/node_modules", "/usr/app/temp" ]

CMD [ "npm", "start" ]
