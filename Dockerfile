FROM jenkins/jenkins:lts

USER root

# Инсталирай Node.js и npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# (по желание) Инсталирай Pulumi глобално
RUN curl -fsSL https://get.pulumi.com | bash

USER jenkins
