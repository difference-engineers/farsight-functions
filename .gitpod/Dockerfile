FROM buildpack-deps:disco

RUN yes | unminimize
RUN apt-get update
RUN apt-get install -yq bash-completion software-properties-common
RUN apt-get install -yq sudo htop jq less multitail gnupg dirmngr postgresql postgresql-contrib postgresql-client ruby-full
RUN apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/*
