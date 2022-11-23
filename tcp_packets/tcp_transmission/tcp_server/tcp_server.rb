#!/usr/bin/env ruby

require 'socket'

PORT = 3030
server = TCPServer.new(PORT)

loop do
  Thread.start(server.accept) do |client|
    client.puts "Hello !"
    client.puts "Time is #{Time.now}"
    client.close
  end
end
