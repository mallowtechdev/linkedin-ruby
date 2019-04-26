require "linkedin-ruby"

# Record and playback LinkedIn API calls
require 'vcr'
VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
end

require 'webmock/rspec'
