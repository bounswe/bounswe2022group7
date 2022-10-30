FROM node:16-alpine
ENV NODE_ENV development
# Set the working directory to /app inside the container
WORKDIR /app
# Copy app files
COPY . .
RUN cd /app
RUN npm install
EXPOSE 1234
ENTRYPOINT ["npm", "run", "start:dev"]