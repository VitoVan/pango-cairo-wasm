FROM fedora:38
COPY . /magic
WORKDIR /magic
ENV magicdir=/magic
RUN bash build.sh
RUN ["chmod", "+x", "/magic/entrypoint.sh"]
ENTRYPOINT ["/magic/entrypoint.sh"]
