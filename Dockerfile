FROM node:14-alpine

WORKDIR /usr/src/app

RUN cp -v /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem /etc/ssl/certs/ca-certificates.crt

ENV NODE_EXTRA_CA_CERTS /etc/ssl/certs/ca-certificates.crt

# Install build dependencies via apk
RUN apk update && apk add python3 g++ make && rm -rf /var/cache/apk/*

# Install node dependencies - done in a separate step so Docker can cache it
COPY package*.json ./
RUN npm install

# Copy project files into the image
COPY . .

# Expose port 8080, which is what the node process is listening to
EXPOSE 8080

# Set the startup command to 'npm start'
CMD [ "npm", "start"] 
