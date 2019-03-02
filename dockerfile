FROM node:10-alpine

WORKDIR /opt/app

ADD . /opt/app
RUN npm install -g -s --no-progess yarn && \
    yarn && \
    yarn build && \
    yarn cache clean
CMD [ "yarn", "serve" ]
EXPOSE 5000
