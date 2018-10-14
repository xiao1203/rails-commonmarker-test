FROM ruby:2.5-alpine3.7

RUN apk update
RUN apk add --no-cache bash nodejs tzdata less sqlite-dev sqlite-libs
RUN apk add --no-cache alpine-sdk \
      --virtual .build_deps libxml2-dev libxslt-dev zlib zlib-dev readline-dev

RUN echo -e 'install: --no-document\nupdate: --no-document' >> ~/.gemrc
RUN gem install bundler

WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install -j4

CMD ["bash"]
