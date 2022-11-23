#!/usr/bin/env ruby
require 'socket'
DST_PORT = 1234
DST_ADDR = '192.168.42.11'


socket = UDPSocket.new
socket.connect(DST_ADDR, DST_PORT)
loop do 
  msg = "hello #{Time.now.to_s}\n"
  puts '=' * 80
  puts msg
  socket.send(msg, 0)
  puts socket.recv(100)
  puts ''
  sleep 2
rescue IOError
  socket.connect(DST_ADDR, DST_PORT)
  echo "Connecting again.."
end
socket.close
