# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# System
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development do
  gem 'annotate'
  gem 'lefthook'
  gem 'listen', '~> 3.3'

  gem 'rubocop-github'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false

  gem 'yard'
  gem 'yard-activerecord'
  gem 'yard-grape'
  gem 'yard-rails'
end

group :test do
  gem 'shoulda', '~> 4.0'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov', require: false, group: :test
end

# System
gem 'activerecord-pg_enum'
gem 'dotenv-rails'
gem 'pg'

# Queue
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'sinatra' # for sidekiq web

# App
gem 'pagy'
gem 'ransack'
gem 'ssl-test'

# Api
gem 'grape'
gem 'grape-entity'
gem 'grape-pagy'
gem 'grape-route-helpers'
gem 'grape-swagger'
gem 'grape-swagger-entity'
