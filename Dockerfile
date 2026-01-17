FROM node:20.20.0

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY . .

RUN apt update && apt install -y mariadb-client \
  && npm i --registry=https://registry.npmmirror.com -g npminstall && npminstall -c

ENV NODE_ENV=production \
  EGG_SERVER_ENV=prod

EXPOSE 8443 8543 9190
CMD ["npm", "run", "start:docker"]
