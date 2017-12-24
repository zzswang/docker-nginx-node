FROM zzswang/docker-nginx-docker:latest

## Build your app inside the docker
ADD package.json /app/package.json
RUN cd /app && npm install
ADD . /app
RUN npm run test:all && NODE_ENV=production npm run build
