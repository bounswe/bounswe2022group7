# First-time configuration
- Run `npm i` inside the frontend directory

# Starting the dev server
- Run `npm start` to build the code and start the development server.
- Go to http://localhost:1234/ to see the code in action.

# Running tests
- `npm test`

# Building the app
- `npm build` builds the app to the dist directory.

<br>

# Docker:

## Building Docker Images
### - Development Environment
`docker build . -t frontend-development`

### - Production Environment
`docker build . -f Dockerfile.production -t frontend-production`

<br>

## Running Docker Containers

### Development Environment
`docker run -p 1234:1234 -d frontend-development`

### Production Environment
`docker run -p 80:80 -d frontend-production` 