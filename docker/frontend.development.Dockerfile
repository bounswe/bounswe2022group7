FROM node:16-alpine
ENV NODE_ENV development
WORKDIR /app
COPY . .
RUN cd /app
RUN npm ci
EXPOSE 3000
ENTRYPOINT ["npm", "run", "start"]