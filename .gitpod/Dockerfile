FROM buildpack-deps:disco

ENV DEBIAN_FRONTEND=noninteractive
RUN yes | unminimize
RUN apt-get update
RUN apt-get install -yq bash-completion software-properties-common sudo
RUN apt-get install -yq htop jq less multitail gnupg dirmngr postgresql postgresql-contrib postgresql-client ruby-full
RUN apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/*
### Gitpod user ###
# '-l': see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
ENV HOME /home/gitpod
WORKDIR $HOME
# custom Bash prompt
RUN { echo && echo "PS1='\[\e]0;\u \w\a\]\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \\\$ '" ; } >> .bashrc
# no root-owned files in the home directory
RUN notOwnedFile=$(find . -not "(" -user gitpod -and -group gitpod ")" -print -quit) && { [ -z "$notOwnedFile" ] || { echo "Error: not all files/dirs in $HOME are owned by 'gitpod' user & group"; exit 1; } }
