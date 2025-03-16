FROM ruby:3.2

WORKDIR /usr/src/app

# 设置国内源和环境变量
ENV LANG=C.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

RUN gem sources --remove https://rubygems.org/ && \
    gem sources -a https://mirrors.tuna.tsinghua.edu.cn/rubygems/ && \
    gem sources -l && \
    bundle config mirror.https://rubygems.org https://mirrors.tuna.tsinghua.edu.cn/rubygems

COPY Gemfile* ./
RUN bundle install

EXPOSE 4000

CMD ["jekyll", "serve", "--host", "0.0.0.0"]
