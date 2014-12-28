FROM ubuntu:12.04
MAINTAINER Wush Wu <wush978@gmail.com>

RUN \
    echo "deb http://tw.archive.ubuntu.com/ubuntu/ precise main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb-src http://tw.archive.ubuntu.com/ubuntu/ precise multiverse" >> /etc/apt/sources.list && \
    echo "deb http://tw.archive.ubuntu.com/ubuntu/ precise-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://tw.archive.ubuntu.com/ubuntu/ precise-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://tw.archive.ubuntu.com/ubuntu/ precise-proposed main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://tw.archive.ubuntu.com/ubuntu/ precise-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get update

ENV LANG zh_TW.UTF-8
WORKDIR /root

# compile and install R
RUN \
    locale-gen zh_TW.UTF-8 && \
    apt-get install -y --no-install-recommends git build-essential libcairo2-dev libtiff4-dev libreadline-dev gfortran wget default-jdk gdebi-core sudo vim fonts-arphic-ukai && \ 
# xvfb xfonts-intl-chinese msttcorefonts xorg-dev
    apt-get clean && \
    wget http://cran.csie.ntu.edu.tw/src/base/R-3/R-3.1.2.tar.gz && \
    tar -zxf R-3.1.2.tar.gz && \
    cd R-3.1.2 && \
    ./configure --with-lapack --enable-R-shlib --enable-BLAS-shlib --enable-memory-profiling --with-x=no && \
    make && \
    make install

# locale
ADD locale /etc/default/locale

# R and shiny
RUN \
    echo "options(repos = 'http://cran.csie.ntu.edu.tw', bitmapType = 'cairo')" > /usr/local/lib/R/etc/Rprofile.site && \
    Rscript -e "install.packages('shiny')" && \
    wget http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.2.3.368-amd64.deb && \
    yes | gdebi shiny-server-1.2.3.368-amd64.deb

CMD ["shiny-server"]
    

