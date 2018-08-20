FROM ubuntu:14.04
MAINTAINER boby thomas <bobypt@gmail.com>

RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-add-repository ppa:brightbox/ruby-ng

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install \
    build-essential \
    nginx \
    python \
    nodejs

RUN \
  DEBIAN_FRONTEND=noninteractive apt-get -y install \
    ruby2.3 \
    ruby2.3-dev

RUN gem install jekyll --no-ri --no-rdoc

RUN gem install jekyll-sitemap jekyll-feed jekyll-paginate jekyll-seo-tag

RUN apt-get install wget
# ADD nginx.conf /etc/nginx/nginx.conf

# CMD ["nginx"]
EXPOSE 4000

VOLUME /topmost
WORKDIR /topmost
ENTRYPOINT ["jekyll", "serve", "--host", "0.0.0.0"]

