#!/usr/bin/env ruby
require 'packetfu'

puts "Capturing network traffic..."
cap = PacketFu::Capture.new(iface: 'eth0', start: true)
cap.stream.each do |raw_packet|
   pkt = PacketFu::Packet.parse(raw_packet)
   next if pkt.is_tcp? || pkt.is_udp? || pkt.is_icmp? || pkt.is_arp?
   next unless pkt.is_eth? && pkt.eth_header.eth_saddr == '02:42:ab:aa:bb:02'
   puts '=' * 80
   puts pkt.inspect
end

