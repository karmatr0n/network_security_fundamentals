require 'packetfu'

eth_pkt = PacketFu::EthPacket.new
eth_pkt.eth_saddr = '02:42:ab:aa:bb:02'
eth_pkt.eth_daddr = '02:42:ab:aa:bb:01'

count = 0
loop do
  eth_pkt.payload = "Ethernet payload #{count += 1}"
  puts '=' * 80
  puts eth_pkt.inspect
  eth_pkt.to_w('eth0')
  sleep(2)
end