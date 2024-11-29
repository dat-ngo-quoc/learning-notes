FROM openjdk:8

ENV NODE_VERSION=14
ENV MAVEN_VERSION=3.8.5
ENV JQ_VERSION=1.6
 
# Install Maven
RUN apt-get update && \
    apt-get install -y curl tar git && \
    curl -fsSL https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar -xz -C /usr/share && \
    ln -s /usr/share/apache-maven-${MAVEN_VERSION} /usr/share/maven && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
    # Clean up
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt-get install -y nodejs && \
    # Clean up
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install jq
RUN curl -Lo /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 && \
    chmod +x /usr/bin/jq && \
    rm -rf /var/lib/apt/lists/*

# Verify installations
RUN java -version && mvn -version && node -v && npm -v && jq --version

# Default working directory
WORKDIR /app

# Default command
CMD ["bash"]
