# Self Signed Searx Docker Container

Simple docker container that will run searx with nginx/uwsgi with a self signed SSL cert.

To run: `docker run -d -p 80:80 -p 443:443 -e MORTY_KEY="morty_key" -e BASE_URL="searx.example.com" -e IMAGE_PROXY="True" adeweever91/searx_ss`

To build:
 - update docker-compose.yml with your base URL, ex. `192.162.1.2` or `https://example.com"
 - Run `docker-compose build`
 - Run `docker-compose up -d`
