FROM node:18.14-alpine3.17

WORKDIR /var/www/app

EXPOSE 5173

ENTRYPOINT [ "npm", "run", "dev" ]
