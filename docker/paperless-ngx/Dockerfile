FROM ghcr.io/paperless-ngx/paperless-ngx:latest
USER root
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	  tesseract-ocr-rus \
 && rm -rf /var/lib/apt/lists/*
USER 1000