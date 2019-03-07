# frozen_string_literal: true

require 'json'
require 'dotenv'
require 'octokit'
require 'byebug'
require 'rack'
require_relative './lib/loc_limiter'
Dotenv.load

ACCESS_TOKEN = ENV['GITHUB_API_KEY']
ADDITIONS_MAX_NUM = ENV['ADDITIONS_MAX_NUM'].to_i

###### SERVER PART #####

@client ||= Octokit::Client.new(access_token: ACCESS_TOKEN)
@selector ||= LocLimiter::FileWhitelister.new

def process_request(req)
  case req.env['HTTP_X_GITHUB_EVENT']
  when 'pull_request'
    payload = JSON.parse(req.params['payload'])
    LocLimiter::Service
      .new(github: @client, file_selector: @selector)
      .perform!(payload)
  end
end

app = proc do |env|
  req = Rack::Request.new(env)
  process_request(req)
  ['200', { 'Content-Type' => 'text/html' }, ['Ok.']]
end

Rack::Handler::WEBrick.run app
