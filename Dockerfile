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

RUN wget -O tai.txt https://github.com/twgo/su5pio2/raw/master/kithann/2018%E5%8F%B0lexicon.txt
RUN wget -O ing.txt https://github.com/twgo/su5pio2/raw/master/kithann/2018%E8%8B%B1lexicon.txt
RUN wget -O hua.txt https://github.com/twgo/su5pio2/raw/master/kithann/2018%E8%8F%AF%E8%AA%9Elexicon
RUN cat tai.txt ing.txt hua.txt >> ka.txt
RUN cp lexicon.txt hethong/dict/lexicon.txt
RUN cat tai.txt ing.txt hua.txt | awk '{print $1}' > pio2.txt

RUN /opt/bin/i686-m64/ngram-count -text pio2.txt -order 1 -lm pio2.arpa

RUN /opt/bin/i686-m64/ngram-count -text bun.txt -order 3 -prune 1e-4 -lm bun1.guan.arpa
RUN /opt/bin/i686-m64/ngram-count -text bun.txt -order 3 -prune 1e-7 -lm bun3.guan.arpa

RUN /opt/bin/i686-m64/ngram -lm bun1.guan.arpa \
  -mix-lm pio2.arpa -lambda 0.1 \
  -write-lm bun1.arpa
RUN /opt/bin/i686-m64/ngram -lm bun3.guan.arpa \
  -mix-lm pio2.arpa -lambda 0.1 \
  -write-lm bun3.arpa

RUN /opt/bin/i686-m64/ngram -lm bun3.arpa -ppl bun.txt

CMD /opt/bin/i686-m64/ngram-count
