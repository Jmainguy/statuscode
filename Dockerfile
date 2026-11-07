FROM cgr.dev/chainguard/ruby:latest-dev@sha256:a08cc63fa79e5b6cd13b99df8e7c239bb63a54050e26f053da722d9e40cef446 AS builder
WORKDIR /work

ENV GEM_HOME=/work/vendor
ENV BUNDLE_PATH=/work/vendor
COPY Gemfile Gemfile.lock /work/
RUN gem install bundler --version 4.0.22 --no-document \
    && bundle config set deployment true \
    && bundle config set without 'development test' \
    && bundle install --jobs 4

FROM cgr.dev/chainguard/ruby:latest@sha256:30a55aacc9e1811c88e55ea3be8dcfac86e5a7fa2f6ae7cd65531df311ed062e
WORKDIR /work

ENV GEM_HOME=/work/vendor/ruby/4.0.0

COPY --from=builder /work/ /work/
COPY app.rb /work/
EXPOSE 4567

ENTRYPOINT ["ruby", "app.rb"]
