FROM node:19.2-alpine
ENV NODE_ENV production
WORKDIR /app
COPY . .
RUN cd /app
RUN npm ci
EXPOSE 3001
CMD ["node" , "app.js"]