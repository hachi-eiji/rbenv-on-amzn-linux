FROM amazonlinux:latest

MAINTAINER Eiji Hachiya<hachiyae@gmail.com>

RUN yum -y update \
  && yum -y install git gcc openssl-devel bzip2 readline-devel tar make

# add dummy file if you check update
RUN git clone --depth 1 https://github.com/sstephenson/rbenv.git /opt/.rbenv \
  && git clone --depth 1 https://github.com/sstephenson/ruby-build.git /opt/.rbenv/plugins/ruby-build \
  && echo -e 'export PATH=/opt/.rbenv/bin:$PATH\neval "$(rbenv init -)"' > /etc/profile.d/rbenv.sh \
  && echo -e 'source /etc/profile' > ~/.bashrc \
  && source /etc/profile.d/rbenv.sh \
  && echo 'gem: --no-rdoc --no-ri' > ~/.gemrc
RUN /opt/.rbenv/plugins/ruby-build/install.sh
COPY versions.txt /opt/versions.txt

RUN bash -l -c 'for v in $(cat /opt/versions.txt); do rbenv install $v; rbenv global $v; gem install bundler; done && rbenv rehash; '
