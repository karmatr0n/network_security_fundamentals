#!/usr/bin/env ruby
require 'pcaprub'

ifname = Pcap.lookupdev

stream = Pcap.open_live(ifname, 0xffff, false, 1)
# 6 octects (48 bits): vendor,  Serial No
eth_saddr = '02:42:ab:aa:bb:02'.split(/[:\x2d\x2e\x5f-]+/).collect {|x| x.to_i(16)}.pack('C6')
eth_daddr = '02:42:ab:aa:bb:01'.split(/[:\x2d\x2e\x5f-]+/).collect {|x| x.to_i(16)}.pack('C6')
eth_proto = [0x0800].pack('n')

count = 0
loop do
  payload = "Simple payload #{count += 1}"
  pkt = [eth_daddr, eth_saddr, eth_proto, payload].join.force_encoding('ASCII-8BIT')
  stream.inject(pkt)
  puts "Sent Packet #{count} (#{pkt.size})"
  sleep(2)
end
