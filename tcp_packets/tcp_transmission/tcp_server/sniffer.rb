#!/usr/bin/env ruby
require 'packetfu'

puts "Capturing network traffic..."
cap = PacketFu::Capture.new(iface: 'eth0', start: true, filter: 'port 3030')
cap.stream.each do |raw_packet|
   pkt = PacketFu::Packet.parse(raw_packet)
   next unless pkt.is_tcp?
   puts '=' * 80
   puts pkt.inspect
   puts ''
end

