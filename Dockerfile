FROM asclinux/linuxforphp-8.1:7.2-zts

COPY entrypoint.sh \
     problem-matcher.json \
     /action/

RUN composer global require guzzlehttp/guzzle
RUN chmod +x /action/entrypoint.sh

ENTRYPOINT ["/action/entrypoint.sh"]
