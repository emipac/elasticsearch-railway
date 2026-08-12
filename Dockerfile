ARG ELASTICSEARCH_VERSION=9.4.4
FROM elasticsearch:${ELASTICSEARCH_VERSION}

COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
COPY roles.yml /usr/share/elasticsearch/config/roles.yml
COPY --chmod=755 entrypoint-new.sh /usr/local/bin/entrypoint-new.sh

# ES 9 image has no apt-get; run as root so entrypoint can chown the Railway volume.
USER 0

ENTRYPOINT ["/usr/local/bin/entrypoint-new.sh"]
