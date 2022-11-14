#!/usr/bin/env ruby
require 'packetfu'

config = PacketFu::Utils.whoami?

puts "Capturing network traffic..."
cap = PacketFu::Capture.new(iface: config[:iface], start: true, filter: 'tcp and port 1337')
cap.stream.each do |raw_packet|
  pkt = PacketFu::Packet.parse(raw_packet)
  next unless pkt.is_tcp?
  puts '=' * 80
  puts pkt.inspect
end