# frozen_string_literal: true

require 'socket'
require_relative 'protocol'

module MongoDB
  class Client
    attr_reader :socket

    def initialize(host, port)
      @socket = TCPSocket.open(host, port)
    end

    def server_build_info
      send_server_build_info
      response = server_reply_msg
      response[:documents] if response.is_a?(MongoDB::Protocol::OpReply)
    end

    def send_server_build_info
      @socket.write(server_build_info_msg)
      @socket.close_write
    end

    def server_reply_msg
      MongoDB::Protocol::OpReply.read(@socket.read)
    end
    private

    def server_build_info_msg
      build_info_msg = MongoDB::Protocol::OpQuery.new(
        flags: 0,
        collection_name: 'test.$cmd',
        number_to_skip: 0,
        number_to_return: -1,
        query_msg: { buildInfo: 1 }
      )
      build_info_msg.header = msg_header(build_info_msg.to_binary_s.size)
      build_info_msg.to_binary_s
    end

    def msg_header(length)
      MongoDB::Protocol::MsgHeader.new(
        message_length: length, request_id: 0, response_to: 0, op_code: MongoDB::Protocol::OpCodes::OP_QUERY
      )
    end
  end
end

