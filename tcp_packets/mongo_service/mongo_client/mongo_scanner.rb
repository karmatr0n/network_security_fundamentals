#!/usr/bin/env ruby
require_relative 'lib/mongo_db'

host = ARGV[0]
port = ARGV[1].chomp

client = MongoDB::Client.new(host, port)
build_info = client.server_build_info
puts build_info