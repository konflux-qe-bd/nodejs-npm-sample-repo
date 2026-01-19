FROM registry.access.redhat.com/ubi10/nodejs-22@sha256:fd5725a11fd0e6d239b1b3b9d84536b7a81a288401c5862c4c59f06ed82a3cff

WORKDIR /app
USER 1001

# Check if the build is performed in hermetic environment
# (without access to the internet)
RUN if curl -s example.com > /dev/null; then echo "build is not being performed in hermetic environment" && exit 1; fi

RUN chown -R 1001:1001 /app

COPY --chown=1001:0 package*.json ./

# Install dependencies
RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
