require 'socket'

PORT = 1337
puts "Starting TCP server on #{PORT} port..."

server = TCPServer.new(PORT)

loop do
  client = server.accept
  
  while client_message = client.gets do
    puts client_message
    server_message = "server_message: #{Time.now}"
    puts server_message
    client.puts(server_message)
  end

  client.close
end