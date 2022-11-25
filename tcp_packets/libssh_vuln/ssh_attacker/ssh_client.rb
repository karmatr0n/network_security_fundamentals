#!/usr/bin/env ruby

require 'net/ssh'

Net::SSH.start('192.168.52.11', 'myuser', password: "mypassword", verbose: :debug) do |ssh|
  output = ssh.exec!("hostname")
  puts "Hostname: #{output}"
end
