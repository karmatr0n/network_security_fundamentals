#!/usr/bin/env ruby
require 'socket'

PORT = 1234
Socket.udp_server_loop(PORT) do |data, src|
  src.reply data
end

