require 'strscan'

module Kernel
  def BDecode(bencoded_string)
    TorrentsPub::BDecoder.new(bencoded_string).decode
  end
end

module TorrentsPub
  class BDecoder
    class BDecodeError < StandardError; end

    attr_reader :scanner

    def initialize(bencoded_string)
      @scanner = StringScanner.new(bencoded_string)
    end

    def decode
      case scanner.peek(1)
      when /\d/; decode_string
      when "i"; decode_integer
      when "l"; decode_list
      when "d"; decode_dictionary
      end
    rescue => e
      raise BDecodeError.new(e)
    end

    def decode_string
      count = Integer(scanner.scan_until(/:/).chop)
      str = scanner.peek(count)
      scanner.pos += count
      str
    end

    def decode_integer
      remove_marker
      Integer(scanner.scan_until(/e/).chop)
    end

    def decode_list
      removing_markers do
        list = []
        while value = decode
          list << value
        end
        list
      end
    end

    def decode_dictionary
      removing_markers do
        dictionary = {}
        until scanner.check(/e/)
          key = decode
          raise "dictionary key must be a string" unless key.is_a?(String)
          value = decode
          dictionary.store(key, value)
        end
        dictionary
      end
    end

    private

    def remove_marker
      scanner.pos += 1
    end

    def removing_markers
      remove_marker
      result = yield
      remove_marker
      result
    end
  end
end

