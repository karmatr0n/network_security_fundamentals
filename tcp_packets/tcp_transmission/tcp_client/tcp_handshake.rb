#!/usr/bin/env ruby
require 'packetfu'

ip = ARGV[0].chomp

config = PacketFu::Utils.whoami?()

syn_packet = PacketFu::TCPPacket.new(:config => config)
syn_packet.ip_daddr = ip
syn_packet.tcp_dst = 3030
syn_packet.tcp_flags.syn = 1
syn_packet.recalc

capture_thread = Thread.new do
  begin
    Timeout::timeout(3) {
      cap = PacketFu::Capture.new(:iface => config[:iface], :start => true)
      cap.stream.each do |p|
        pkt = PacketFu::Packet.parse p
        next unless pkt.is_tcp?

        if pkt.ip_saddr == ip &&
           pkt.tcp_flags.syn == 1 &&
           pkt.tcp_flags.ack == 1

          puts "Got SYN/ACK reply from #{ip}"

          syn_ack_packet = pkt
          ack_packet = syn_packet.dup
          ack_packet.tcp_flags.syn = 0
          ack_packet.tcp_flags.ack = 1
          ack_packet.tcp_ack = syn_ack_packet.tcp_seq + 1
          ack_packet.tcp_seq = syn_ack_packet.tcp_ack

          puts "Sending ACK reply to #{ip}"
          ack_packet.to_w
          break
        end
      end
    }
  rescue Timeout::Error
    puts "SYN request timed out"
  end
end

puts "Sending SYN request to #{ip}"
syn_packet.to_w

capture_thread.join
