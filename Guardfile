guard 'jasmine-headless-webkit', :jasmine_config => File.join(File.dirname(__FILE__), 'spec', 'coffeescripts', 'support', 'jasmine.yml') do
  watch(%r{^assets/coffeescripts/(.*)\..*}) { |m| newest_js_file("spec/coffeescripts/#{m[1]}_spec") }
end
