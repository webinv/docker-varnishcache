FROM debian:jessie

# Maintainer
LABEL maintainer "krzysztof@kardasz.eu"

# Update system and install required packages
ENV DEBIAN_FRONTEND noninteractive

RUN \
    apt-get update && \
    apt-get -y install apt-transport-https curl telnet wget vim && \
    curl https://packagecloud.io/install/repositories/varnishcache/varnish5/script.deb.sh | bash && \
    apt-get -y install varnish && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 80 6082

CMD ["varnishd", "-F", "-a", ":80", "-T", ":6082", "-f", "/etc/varnish/default.vcl", "-s", "malloc,256m"]
