FROM ubuntu:18.04
MAINTAINER sih4sing5hong5


RUN apt-get update -qq && \
  apt-get install -y locales \
    g++ make
RUN locale-gen zh_TW.UTF-8
ENV LANG zh_TW.UTF-8
ENV LC_ALL zh_TW.UTF-8

WORKDIR /opt
COPY srilm-1.7.2.tar.gz .
RUN tar -xzvf srilm-1.7.2.tar.gz
RUN sed '5iSRILM=/opt' -i Makefile
RUN make

COPY --from=twgo/bunpun /usr/local/hok8-bu7/tsiau-bopiautiam/* tsiau/
RUN cat tsiau/* > bun.txt
RUN /opt/bin/i686-m64/ngram-count -text bun.txt -lm bun.arpa
RUN /opt/bin/i686-m64/ngram -lm bun.arpa -ppl bun.txt

CMD /opt/bin/i686-m64/ngram-count
