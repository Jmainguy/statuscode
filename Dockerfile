FROM cgr.dev/chainguard/ruby:latest-dev as builder

ENV GEM_HOME=/work/vendor
ENV GEM_PATH=${GEM_PATH}:/work/vendor
COPY Gemfile /work/
RUN gem install bundler && bundle install

FROM cgr.dev/chainguard/ruby:latest

ENV GEM_HOME=/work/vendor
ENV GEM_PATH=${GEM_PATH}:/work/vendor

COPY --from=builder /work/ /work/
COPY app.rb /work/
EXPOSE 4567

ENTRYPOINT [ "ruby", "app.rb" ]
