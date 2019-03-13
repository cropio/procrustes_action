#! /bin/ruby
# frozen_string_literal: true

require 'json'
require 'dotenv'
require 'octokit'
require_relative './lib/procrustes'
Dotenv.load

# ENV CONFIG

ACCESS_TOKEN = ENV.fetch('GITHUB_TOKEN')
GITHUB_EVENT_PATH = ENV.fetch('GITHUB_EVENT_PATH')

puts "RUNNIG PR CHECK WITH MAX SIZE #{Procrustes::ADDITIONS_MAX_NUM}"
###### APP PART #####

@client ||= Octokit::Client.new(access_token: ACCESS_TOKEN)
@selector ||= Procrustes::FileWhitelister.new

payload = JSON.parse(File.read(GITHUB_EVENT_PATH))
status = \
  Procrustes::Service
  .new(github: @client, file_selector: @selector)
  .perform!(payload)

exit 1 unless status
