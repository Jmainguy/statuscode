FROM cgr.dev/chainguard/ruby:latest-dev@sha256:c8fe25b7f978a2f3b726c7f880b07d3830a2c54ff465d68fcabe1904c0614a4a AS builder
WORKDIR /work

ENV GEM_HOME=/work/vendor
ENV BUNDLE_PATH=/work/vendor
COPY Gemfile Gemfile.lock /work/
RUN gem install bundler --version 4.0.19 --no-document \
    && bundle config set deployment true \
    && bundle config set without 'development test' \
    && bundle install --jobs 4

FROM cgr.dev/chainguard/ruby:latest@sha256:131133f16cce670884fb31cea12f76a9d3a6aa188a5497300d7e4d2722476df7
WORKDIR /work

ENV GEM_HOME=/work/vendor/ruby/4.0.0

COPY --from=builder /work/ /work/
COPY app.rb /work/
EXPOSE 4567

ENTRYPOINT ["ruby", "app.rb"]
