#!/bin/sh

if [ ! -f /usr/local/searx/ssl/searx.key ]
then
    mkdir -p /usr/local/searx/ssl
    openssl req \
       -subj "/C=${COUNRTY:-''}/ST=${STATE:-''}/L=${LOCALITY:-''}/O=${ORG:-''}/OU=${ORG_UNIT:=''}/CN=${COMMON_NAME:-''}" \
       -newkey rsa:4096 -nodes -keyout /usr/local/searx/ssl/searx.key \
       -x509 -days 3650 -out /usr/local/searx/ssl/searx.crt
fi

sed -i -e "s|base_url : False|base_url : ${BASE_URL}|g" \
       -e "s/image_proxy : False/image_proxy : ${IMAGE_PROXY}/g" \
       -e "s/ultrasecretkey/$(openssl rand -hex 16)/g" \
       /usr/local/searx/searx/settings.yml

supervisord -c /etc/supervisord.conf
