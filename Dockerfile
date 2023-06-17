FROM node:18

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY . .

RUN npm install --registry=https://registry.npmmirror.com -g npminstall \
  && npminstall -c -d

ENV NODE_ENV=production \
  EGG_SERVER_ENV=prod

EXPOSE 8443 8543 9190
CMD ["npm", "run", "start:foreground"]
