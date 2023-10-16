FROM ubuntu

RUN apt update -qq && apt upgrade -y -qq
RUN apt install sudo -y -qq

RUN useradd --password testing -m tester
RUN usermod -aG sudo tester
RUN su - tester

COPY . /home/tester/.dotfiles
