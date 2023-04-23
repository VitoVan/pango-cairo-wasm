FROM fedora
COPY . /magic
WORKDIR /magic
RUN bash build.sh
RUN . env.sh
ENTRYPOINT ["emcc"]
CMD ["--help"]