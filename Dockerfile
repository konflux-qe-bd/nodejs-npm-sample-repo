FROM registry.access.redhat.com/ubi10/nodejs-22@sha256:83bc7ac14c2342725fef7721f8d1f6e0d8dc7bafbd4f40ffea37b440bf4818e8

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
