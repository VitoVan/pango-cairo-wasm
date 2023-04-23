FROM fedora
COPY . /magic
WORKDIR /magic
RUN bash build.sh
RUN ["chmod", "+x", "/magic/entrypoint.sh"]
ENTRYPOINT ["/magic/entrypoint.sh"]
