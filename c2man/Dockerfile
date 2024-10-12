FROM debian
COPY . /main
WORKDIR /main
RUN apt update && apt install git -y && apt install flex -y && apt install make -y && apt install yacc -y
RUN sh c2man.sh