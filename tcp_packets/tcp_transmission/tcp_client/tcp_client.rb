#!/usr/bin/env ruby

require "socket"

DST_ADDR = '192.168.62.11'
DST_PORT = 3030

socket = TCPSocket.open(DST_ADDR, DST_PORT)

while line = socket.gets do
  puts line
end 
socket.close
