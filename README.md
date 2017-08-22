# Self Signed Searx Docker Container

Simple docker container that will run searx with nginx/uwsgi with a self signed SSL cert.

To run: `docker run -p 80:80 -p 443:443 -e BASE_URL="searx.example.com" -e IMAGE_PROXY="True" adeweever/searx_ss`
