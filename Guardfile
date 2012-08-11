guard 'jasmine-headless-webkit', :jasmine_config => File.join(File.dirname(__FILE__), 'spec', 'backbone', 'support', 'jasmine.yml') do
  watch(%r{^assets/backbone/(.*)\..*}) { |m| newest_js_file("spec/backbone/#{m[1]}_spec") }
  watch(%r{^spec/backbone/(.*)\..*})
end
