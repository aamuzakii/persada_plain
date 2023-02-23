# Use the official Ruby image as the base image
FROM ruby:3.1.2-alpine

# Set the working directory to /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the image and install gems
COPY Gemfile Gemfile.lock ./
RUN apk add --no-cache --virtual .build-deps build-base postgresql-dev \
    && bundle install --jobs 20 --retry 5 \
    && apk del .build-deps

# Copy the rest of the application code into the image
COPY . .

# Set Rails environment variable
ENV RAILS_ENV=production

# Precompile assets
RUN bundle exec rails assets:precompile

# Set the default command to start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
