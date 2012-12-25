require 'spec_helper'
require 'core/bdecode'

describe "BDecode" do
  it "decodes valid bencoded string" do
    expect(decode("3:foo")).to eq("foo")
  end

  it "raises on unexpected EOS" do
    expect { decode("10:foo") }.to raise_error(BDecoder::BDecodeError)
  end

  it "decodes short integer" do
    expect(decode("i1e")).to eq(1)
  end

  it "decodes long integer" do
    max_int = 1 << (1.size * 8 - 2) - 1 # i.e. 2305843009213693952
    expect(decode("i#{max_int}e")).to eq(max_int)
  end

  it "decodes negative integer" do
    expect(decode("i-10e")).to eq(-10)
  end

  it "raises on malformed integer" do
    expect { decode("i1be") }.to raise_error(BDecoder::BDecodeError)
  end

  it "raises on unterminated integer" do
    expect { decode("i100") }.to raise_error(BDecoder::BDecodeError)
  end

  it "decodes empty lists" do
    expect(decode("le")).to eq([])
  end

  it "decodes list of strings" do
    expect(decode("l3:foo4:quuxe")).to eq(%w(foo quux))
  end

  it "decodes list of strings and ints" do
    expect(decode("l3:fooi11ee")).to eq(["foo", 11])
  end

  it "raises on unterminated list" do
    expect { decode("l") }.to raise_error(BDecoder::BDecodeError)
  end

  it "decodes empty dictionary" do
    expect(decode("de")).to eq({})
  end

  it "decodes dictionary" do
    expect(decode("d3:fool1:a1:be4:quuxi11ee")).to eq("foo" => ["a", "b"], "quux" => 11)
  end

  {
    "integers" => "i1e",
    "lists" => "li1ee",
    "dictionaries" => "d3:fooi1ee"
  }.each do |key_type, key|
    it "does not allow #{key_type} as dictionary keys" do
      expect { decode("d#{key}i10ee") }.to raise_error(BDecoder::BDecodeError, /must be a string/)
    end
  end

  def decode(bencoded_string)
    BDecode(bencoded_string)
  end
end

