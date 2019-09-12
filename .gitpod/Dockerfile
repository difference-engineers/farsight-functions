FROM buildpack-deps:disco

ENV LANG=en_US.UTF-8

RUN yes | unminimize
RUN apt-get update
RUN apt-get install -yq bash-completion locales software-properties-common
RUN apt-get install -yq sudo htop jq less multitail gnupg dirmngr postgresql postgresql-client ruby-full
RUN locale-gen en_US.UTF-8
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*
