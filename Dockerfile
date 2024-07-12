# Use the official PostgreSQL 16 image as the base
FROM postgres:16

# Define the Spock extension version as an environment variable
ENV SPOCK_VERSION 3.3.5-1

# Install necessary packages for downloading and extracting files
RUN apt update && \
    apt install -y wget tar && \
    apt clean all && \
    rm -rf /var/lib/apt/lists/*

# Download and extract the Spock extension
RUN wget https://pgedge-upstream.s3.amazonaws.com/REPO/spock33-pg16-${SPOCK_VERSION}-amd.tgz -O /tmp/spock.tgz && \
    mkdir -p /tmp/spock && \
    tar -xzvf /tmp/spock.tgz -C /tmp/spock --strip-components=1 && \
    cp /tmp/spockshare/postgresql/extension/* /usr/share/postgresql/16/extension/ && \
    cp -r /tmp/spocklib/postgresql/* /usr/lib/postgresql/16/lib/ && \
    cp /tmp/spockbin/* /usr/lib/postgresql/16/bin/ && \
    rm -rf /tmp/spock.tgz /tmp/spock33-pg16 && \
    apt remove -y wget 
