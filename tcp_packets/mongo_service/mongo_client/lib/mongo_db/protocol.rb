# frozen_string_literal: true

require 'bindata'
require 'bson'

module MongoDB
  module Protocol
    class BSONDocument < BinData::BasePrimitive
      def value_to_binary_string(value)
        value.to_bson.to_s
      end

      def read_and_return_value(io)
        buffer = BSON::ByteBuffer.new(io.read_all_bytes)
        BSON::Document.from_bson(buffer)
      rescue StandardError => e
        raise IOError, "Invalid BSON: #{e.inspect}"
      end
    end

    # https://www.mongodb.com/docs/manual/reference/mongodb-wire-protocol/#standard-message-header
    class MsgHeader < BinData::Record
      endian :little
      int32  :message_length
      int32  :request_id
      int32  :response_to
      int32  :op_code
    end

    # https://www.mongodb.com/docs/manual/reference/mongodb-wire-protocol/#op_reply
    class OpReply < BinData::Record
      endian :little
      msg_header :header
      uint32 :response_flags
      uint64 :cursor_id
      uint32 :starting_from
      uint32 :number_returned
      array :documents, type: :bson_document, initial_length: -> { number_returned }
    end

    # https://www.mongodb.com/docs/manual/reference/mongodb-wire-protocol/#op_query
    class OpQuery < BinData::Record
      endian :little
      msg_header :header
      int32 :flags
      stringz :collection_name
      int32 :number_to_skip
      int32 :number_to_return
      bson_document :query_msg
    end

    # https://www.mongodb.com/docs/manual/reference/mongodb-wire-protocol/#op_msg
    class OpMsg < BinData::Record
      endian :little
      msg_header :header
      uint32 :flag_bits
      uint8 :kind
      array :docs, type: :bson_document, initial_length: 1
    end

    # https://www.mongodb.com/docs/manual/reference/mongodb-wire-protocol/#request-opcodes
    module OpCodes
      OP_REPLY = 1
      OP_UPDATE = 2001
      OP_INSERT = 2002
      RESERVED  = 2003
      OP_QUERY  = 2004
      OP_GET_MORE = 2005
      OP_DELETE = 2006
      OP_KILL_CURSORS = 2007
      OP_COMPRESSED = 2012
      OP_MSG = 2013
    end
  end
end
