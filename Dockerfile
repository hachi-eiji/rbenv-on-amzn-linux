FROM amazonlinux:latest

MAINTAINER Eiji Hachiya<hachiyae@gmail.com>

RUN yum -y update \
  && yum -y install git gcc openssl-devel bzip2 readline-devel \
  && git clone git://github.com/sstephenson/rbenv.git ~/.rbenv \
  && PATH="$HOME/.rbenv/bin:$PATH" \
  && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc \
  && echo 'eval "$(rbenv init -)"' >> ~/.bashrc \
  && source ~/.bashrc \
  && git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build \
  && rbenv install 2.3.0 && rbenv global 2.3.0

CMD ["/bin/bash"]
