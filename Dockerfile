FROM amazonlinux:latest

MAINTAINER Eiji Hachiya<hachiyae@gmail.com>

RUN yum -y update \
  && yum -y install git gcc openssl-devel bzip2 readline-devel

# add dummy file if you check update
RUN git clone --depth 1 https://github.com/sstephenson/rbenv.git ~/.rbenv \
  && git clone --depth 1 https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build \
  && echo -e 'export PATH=~/.rbenv/bin:$PATH\neval "$(rbenv init -)"' > /etc/profile.d/rbenv.sh \
  && echo -e 'source /etc/profile' > ~/.bashrc \
  && source /etc/profile.d/rbenv.sh \
  && echo 'gem: --no-rdoc --no-ri' > ~/.gemrc

RUN bash -lc 'for v in 2.3.0; do rbenv install $v; rbenv global $v; gem install bundler; done'
