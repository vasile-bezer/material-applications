FROM docker:25-git

WORKDIR /usr/src/app

COPY builder.sh ./
RUN chmod +x builder.sh

WORKDIR /usr/src/app

ENTRYPOINT ["/usr/src/app/builder.sh"]