FROM cgr.dev/chainguard/ruby:latest-dev@sha256:9caaf3d52f9d9a18ace549352136816d4bfe2bc8bbecec1318ea059ab2503ccb AS builder
WORKDIR /work

ENV GEM_HOME=/work/vendor
ENV BUNDLE_PATH=/work/vendor
COPY Gemfile Gemfile.lock /work/
RUN gem install bundler --version 4.0.19 --no-document \
    && bundle config set deployment true \
    && bundle config set without 'development test' \
    && bundle install --jobs 4

FROM cgr.dev/chainguard/ruby:latest@sha256:8c10fff2d529ac801a6ba97db2cbaf372439c66c27bb1c2d95a779dd711bcc02
WORKDIR /work

ENV GEM_HOME=/work/vendor/ruby/4.0.0

COPY --from=builder /work/ /work/
COPY app.rb /work/
EXPOSE 4567

ENTRYPOINT ["ruby", "app.rb"]
