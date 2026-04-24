FROM registry.access.redhat.com/ubi10/nodejs-22@sha256:7c1dd648bb4aced67e6f43d578a2acbd496dffb43bcc46377dbe7b878b24f5fa

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
