#!/usr/bin/env ruby
require 'packetfu'

def decrypt_payload(string, key = 0x42)
  string.bytes.map {|b| b ^ key }.pack('C*')
end

puts "Capturing network traffic..."
cap = PacketFu::Capture.new(iface: 'eth0', start: true)
cap.stream.each do |raw_packet|
   pkt = PacketFu::Packet.parse(raw_packet)
   next unless pkt.is_icmp? && pkt.ip_saddr == '192.168.32.11'
   puts '=' * 80
   puts decrypt_payload(pkt.payload)
   puts ''
end

