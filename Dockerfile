FROM cgr.dev/chainguard/ruby:latest-dev@sha256:05ff10666b0487c3240ff5b629a3d658b0770305fec4e47a8085e182fd68934f AS builder
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
