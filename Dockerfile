ARG ELASTICSEARCH_VERSION=9.4.4
FROM elasticsearch:${ELASTICSEARCH_VERSION}

COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
COPY roles.yml /usr/share/elasticsearch/config/roles.yml
COPY --chmod=755 entrypoint-new.sh /usr/local/bin/entrypoint-new.sh

USER 0
# ES 9 image has no apt-get/sudo/setpriv; ship a static gosu for privilege drop.
ADD --chmod=755 https://github.com/tianon/gosu/releases/download/1.17/gosu-amd64 /usr/local/bin/gosu

ENTRYPOINT ["/usr/local/bin/entrypoint-new.sh"]
