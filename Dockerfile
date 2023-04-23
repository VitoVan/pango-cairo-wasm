FROM fedora
COPY . /magic
WORKDIR /magic
RUN bash build.sh
ENTRYPOINT ["/magic/entrypoint.sh"]
