# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'dotenv'
gem 'octokit', '~> 4.13'

group :development do
  gem 'byebug'
  gem 'pry'
  gem 'rspec'
  gem 'rubocop'
end

group :test do
  gem 'rubocop-rspec'
  gem 'simplecov', require: false
end
