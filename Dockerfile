FROM fedora
COPY . /magic
WORKDIR /magic
RUN bash build.sh
CMD emcc