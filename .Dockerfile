FROM jekyll/jekyll

# Set the working directory
WORKDIR /app

# Install dependencies
COPY Gemfile* ./
RUN gem install bundler && bundle install
