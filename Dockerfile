FROM alpine:3.6

RUN apk -U upgrade \
    && apk add -t build-dependencies \
                  build-base \
                  python-dev \
                  libffi-dev \
                  libxslt-dev \
                  libxml2-dev \
                  openssl-dev \
                  tar \
                  ca-certificates \
                  linux-headers \
                  pcre-dev \
    && apk add \
           nginx \
           su-exec \
           python \
           libxml2 \
           libxslt \
           openssl \
           tini \
           py2-pip \
           supervisor

RUN mkdir -p /run/nginx \
    && pip install --no-cache -r https://raw.githubusercontent.com/asciimoo/searx/master/requirements.txt \
    && pip install 'https://github.com/unbit/uwsgi/archive/uwsgi-2.0.zip#egg=uwsgi' \
    && mkdir /usr/local/searx \
    && cd /usr/local/searx \
    && wget -qO- https://github.com/asciimoo/searx/archive/master.tar.gz | tar xz --strip 1 \
    && sed -i "s/127.0.0.1/0.0.0.0/g" searx/settings.yml \
    && apk del build-dependencies \
    && rm -f /var/cache/apk/* \
    && rm /etc/supervisord.conf \
    && mkdir -p /etc/uwsgi/ \
    && addgroup -S searx \
    && adduser -S -G searx -h /usr/local/searx searx

COPY ./configs /configs
COPY entry_point.sh /usr/local/bin/entry_point.sh
VOLUME /nginx

RUN chmod +x /usr/local/bin/entry_point.sh \
    && ln -s /configs/searx.ini /etc/uwsgi/ \
    && ln -s /configs/supervisord.conf /etc/ \
    && rm /etc/nginx/conf.d/default.conf \
    && cp /configs/default.conf /etc/nginx/conf.d/

EXPOSE 80 443

CMD ["entry_point.sh"]

