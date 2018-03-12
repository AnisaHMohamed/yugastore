FROM node:latest

# App install directory
WORKDIR /usr/local/yugastore

#
# Install app dependencies.
#

# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# If you are building your code for production, add '--only=production'.
RUN npm install --only=production

# Bundle app source.
COPY app.js ./
ADD bin ./bin
ADD config ./config
ADD models ./models
ADD routes ./routes
ADD ui ./ui

# Set the config file.
COPY config/config.docker.json ./config.json

# Expose necessary ports.
EXPOSE 3001

# Start npm.
CMD [ "./bin/start.sh" ]

#
# To build:
#   docker build -t yugastore .
#
# To run:
#   docker run -p 3001:3001 -d --network yb-net --name yugastore yugastore
#
# Connect the container to the yb network:
#   docker network connect yb-net yugastore
#
# Init:
#   node models/yugabyte/db_init.js yb-tserver-n1
#
# Stop:
#   docker stop yugastore
#   docker rm yugastore
#
