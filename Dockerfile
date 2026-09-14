FROM cgr.dev/chainguard/ruby:latest-dev@sha256:a4077a55ca2d3bb0cb2ec3f6a4a831b64d8adb18e72a8c467e877adfe32ac20f AS builder
WORKDIR /work

ENV GEM_HOME=/work/vendor
ENV BUNDLE_PATH=/work/vendor
COPY Gemfile Gemfile.lock /work/
RUN gem install bundler --version 4.0.19 --no-document \
    && bundle config set deployment true \
    && bundle config set without 'development test' \
    && bundle install --jobs 4

FROM cgr.dev/chainguard/ruby:latest@sha256:c2059f720ada317738b9aa1045839c48d8114aee3930a2662faac26e9b91755d
WORKDIR /work

ENV GEM_HOME=/work/vendor/ruby/4.0.0

COPY --from=builder /work/ /work/
COPY app.rb /work/
EXPOSE 4567

ENTRYPOINT ["ruby", "app.rb"]
