FROM node:16-alpine
ENV NODE_ENV development
# Set the working directory to /app inside the container
WORKDIR /app
# Copy app files
COPY . .
RUN npm install
EXPOSE 1234
CMD ["npm", "start"]