require 'spec_helper'
require 'core/torrent_meta_info'

describe "TorrentMetaInfo" do
  let(:file1) { { "name" => "test1.wav", "length" => 100 } }
  let(:file2) { { "name" => "test2.wav", "length" => 200 } }

  let(:single_file_meta_info) { TorrentMetaInfo.new("creation date" => 1356171737, "info" => file1) }
  let(:multi_file_meta_info) { TorrentMetaInfo.new("creation date" => 1356171737, "info" => { "name" => "things", "files" => [file1, file2] }) }

  describe "#files" do
    it "returns a list of files for single file torrent" do
      expect(single_file_meta_info.files).to eq([file1])
    end

    it "returns a lias of files for multi file torrent" do
      expect(multi_file_meta_info.files).to eq([file1, file2])
    end
  end

  describe "#total_length" do
    it "gives summary length of all files" do
      expect(multi_file_meta_info.total_length).to eq(300)
    end
  end

  describe "#creation_date" do
    it "returns torrent creation Time object" do
      expect(single_file_meta_info.creation_date).to eq(Time.at(1356171737))
    end
  end
end

