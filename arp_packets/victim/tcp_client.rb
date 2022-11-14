require 'socket'

socket = TCPSocket.new('192.168.90.10', 1337)

loop do
  client_message = "client_message: #{Time.now}"
  puts client_message
  socket.puts(client_message)
  
  server_message = socket.gets
  puts server_message

  sleep(2)
end

socket.close 