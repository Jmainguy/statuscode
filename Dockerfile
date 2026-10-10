FROM cgr.dev/chainguard/ruby:latest-dev@sha256:5d2a0037b63e804d65a2c7deb5209603e339ad50037e19f18a4e00c282292ba8 AS builder
WORKDIR /work

ENV GEM_HOME=/work/vendor
ENV BUNDLE_PATH=/work/vendor
COPY Gemfile Gemfile.lock /work/
RUN gem install bundler --version 4.0.22 --no-document \
    && bundle config set deployment true \
    && bundle config set without 'development test' \
    && bundle install --jobs 4

FROM cgr.dev/chainguard/ruby:latest@sha256:d7d64465a7bcf5c704213e2645b7776aaa8c3d3f8b1d8b9223656017bec522a2
WORKDIR /work

ENV GEM_HOME=/work/vendor/ruby/4.0.0

COPY --from=builder /work/ /work/
COPY app.rb /work/
EXPOSE 4567

ENTRYPOINT ["ruby", "app.rb"]
