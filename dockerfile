FROM node:10

WORKDIR /opt/www
RUN npm install -g -s --no-progess yarn
COPY package*.json ./
RUN yarn install

COPY . .

EXPOSE 5000
CMD ["yarn", "serve"]
