FROM cgr.dev/chainguard/ruby:latest-dev@sha256:7aa69bbc11b6b63dfc937144ed00c1611a9ea88e652d92b211e62519a79c256f AS builder
WORKDIR /work

ENV GEM_HOME=/work/vendor
ENV BUNDLE_PATH=/work/vendor
COPY Gemfile Gemfile.lock /work/
RUN gem install bundler --version 4.0.19 --no-document \
    && bundle config set deployment true \
    && bundle config set without 'development test' \
    && bundle install --jobs 4

FROM cgr.dev/chainguard/ruby:latest@sha256:f5df82e25e81537ea2763260f4006e4d5385826d389c0296c2126923ef9eadd1
WORKDIR /work

ENV GEM_HOME=/work/vendor/ruby/4.0.0

COPY --from=builder /work/ /work/
COPY app.rb /work/
EXPOSE 4567

ENTRYPOINT ["ruby", "app.rb"]
