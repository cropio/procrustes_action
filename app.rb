#! /bin/ruby
# frozen_string_literal: true

require 'json'
require 'dotenv'
require 'octokit'
require 'byebug'
require_relative './lib/loc_limiter'
Dotenv.load

# ENV CONFIG

ACCESS_TOKEN = ENV.fetch('GITHUB_TOKEN')
GITHUB_EVENT_PATH = ENV.fetch('GITHUB_EVENT_PATH')
ADDITIONS_MAX_NUM = ENV.fetch('ADDITIONS_MAX_NUM', 1000).to_i

puts "RUNNIG PR CHECK WITH MAX SIZE #{ADDITIONS_MAX_NUM}"
###### APP PART #####

@client ||= Octokit::Client.new(access_token: ACCESS_TOKEN)
@selector ||= LocLimiter::FileWhitelister.new

payload = JSON.parse(File.read(GITHUB_EVENT_PATH))
LocLimiter::Service
  .new(github: @client, file_selector: @selector)
  .perform!(payload)
