FROM node:16-alpine as builder
# Set the working directory to /app inside the container
WORKDIR /app
# Copy app files
COPY . .
RUN npm ci 
# Build the app
RUN npm run build

# Bundle static assets with nginx
FROM nginx:1.22.1-alpine as production
ENV NODE_ENV production
# Copy built assets from `builder` image
COPY --from=builder /app/build /var/www
# Add your nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Expose port
EXPOSE 80
# Start nginx
CMD ["nginx", "-g", "daemon off;"]