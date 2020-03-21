FROM wordpress
ADD ./key.json /key.json
ADD ./startup.sh /usr/local/bin/entrypoint.sh
ENV GOOGLE_APPLICATION_CREDENTIALS /key.json
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE 1


RUN chmod a+x /usr/local/bin/entrypoint.sh && \
    apt-get update && \
    apt-get install -y lsb-release gnupg1 gnupg2 && \
    export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s` && \
    echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" > /etc/apt/sources.list.d/gcsfuse.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add - && \
    apt-get update && \
    apt-get install -y gcsfuse

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
