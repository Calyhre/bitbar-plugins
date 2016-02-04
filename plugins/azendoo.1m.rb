#!/usr/bin/env rbenv-ruby

require 'dotenv'
require 'json'
require 'net/http'

Dotenv.load(File.join __dir__, '../.env')

authorization_header = "Token token=#{ENV['AZENDOO_API_KEY']}"
uri = URI('https://app.azendoo.com/api/direct_messages')

Net::HTTP.start(uri.host,
                uri.port,
                use_ssl: uri.scheme == 'https') do |http|

  request = Net::HTTP::Get.new uri.request_uri
  request.add_field('Authorization', authorization_header)

  response      = http.request request
  json          = JSON.parse(response.body)

  unread = json['data'].select { |d| !d['read'] }

  puts "#{unread.count.zero? ? '⚪️' : '🔴'} | dropdown=false"
  puts '---'
  puts "#{unread.count} unread message(s)"
end
