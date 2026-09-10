FROM cgr.dev/chainguard/ruby:latest-dev@sha256:a4077a55ca2d3bb0cb2ec3f6a4a831b64d8adb18e72a8c467e877adfe32ac20f AS builder
WORKDIR /work

ENV GEM_HOME=/work/vendor
ENV BUNDLE_PATH=/work/vendor
COPY Gemfile Gemfile.lock /work/
RUN gem install bundler --version 4.0.19 --no-document \
    && bundle config set deployment true \
    && bundle config set without 'development test' \
    && bundle install --jobs 4

FROM cgr.dev/chainguard/ruby:latest@sha256:264a473f6adb17e65f5103f6764aa7c4db1a59cade1e0103b54d3e65d1e169c7
WORKDIR /work

ENV GEM_HOME=/work/vendor/ruby/4.0.0

COPY --from=builder /work/ /work/
COPY app.rb /work/
EXPOSE 4567

ENTRYPOINT ["ruby", "app.rb"]
