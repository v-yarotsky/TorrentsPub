module TorrentsPub
  module Rules
  end
end

Dir.glob(File.dirname(__FILE__) + '/rules/*_rule.rb') do |rule|
  require rule
end
