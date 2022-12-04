FROM node:19.2-alpine
ENV NODE_ENV development
WORKDIR /app
COPY . .
RUN cd /app
RUN npm i
EXPOSE 3001
CMD ["node" , "app.js"]