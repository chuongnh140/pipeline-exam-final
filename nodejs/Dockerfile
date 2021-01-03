FROM node:15.5-stretch-slim
WORKDIR /app
COPY index.js *.json /app/
RUN npm install
EXPOSE 3000
CMD npm start

