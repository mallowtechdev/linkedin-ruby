require "oauth2"

require "linked_in/errors"
require "linked_in/raise_error"
require "linked_in/version"
require "linked_in/configuration"

# Responsible for all authentication
# LinkedIn::OAuth2 inherits from OAuth2::Client
require "linked_in/oauth2"

# Wraps a LinkedIn-specifc API connection
# LinkedIn::Connection inherits from Faraday::Connection
require "faraday"
require "linked_in/connection"

# Data object to wrap API access token
require "linked_in/access_token"

require "linked_in/api"
require "linked_in/api_resource"
require "linked_in/share_and_social_stream"
require 'linked_in/people'
require "linked_in/organizations"

module LinkedIn
  @config = Configuration.new

  class << self
    attr_accessor :config
  end

  def self.configure
    yield self.config
  end
end
