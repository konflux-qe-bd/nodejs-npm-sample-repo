FROM registry.access.redhat.com/ubi10/nodejs-22@sha256:18d22a1aa4bf5ceb93c733f51c578a71a77412001c0412e380c5ac67b38a8d8f

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
