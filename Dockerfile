FROM cgr.dev/chainguard/ruby:latest-dev@sha256:808235447b687687930e30f9b6b26c82fb858f0f8776ddca8c4c82dbea4cfce0 AS builder
WORKDIR /work

ENV GEM_HOME=/work/vendor
ENV BUNDLE_PATH=/work/vendor
COPY Gemfile Gemfile.lock /work/
RUN gem install bundler --version 4.0.19 --no-document \
    && bundle config set deployment true \
    && bundle config set without 'development test' \
    && bundle install --jobs 4

FROM cgr.dev/chainguard/ruby:latest@sha256:df06cf8134f82a4aecb71a6e1dac792ee93e6604220aab767405780198042841
WORKDIR /work

ENV GEM_HOME=/work/vendor/ruby/4.0.0

COPY --from=builder /work/ /work/
COPY app.rb /work/
EXPOSE 4567

ENTRYPOINT ["ruby", "app.rb"]
