require 'time'
module LinkedIn
  # People APIs
  #
  # @see http://developer.linkedin.com/documents/people People API
  # @see http://developer.linkedin.com/documents/profile-fields Profile Fields
  # @see http://developer.linkedin.com/documents/field-selectors Field Selectors
  # @see http://developer.linkedin.com/documents/accessing-out-network-profiles Accessing Out of Network Profiles
  class People < APIResource

    # @!macro multi_profile_options
    #   @options opts [Array]  :urls A list of profile urls
    #   @options opts [Array]  :ids List of LinkedIn IDs
    #
    # @!macro new profile_args
    #   @overload profile()
    #     Fetches your own profile
    #   @overload profile(id_or_url, opts)
    #     Fetches the profile of another user
    #     @param [String] id_or_url a LinkedIn id or a profile URL
    #     @param [Hash] opts more profile options
    #     @macro profile_options
    #   @overload profile(opts)
    #     Fetches the profile of another user
    #     @param [Hash] opts profile options
    #     @macro profile_options
    #   @return [LinkedIn::Mash]

    # Retrieve a member's LinkedIn profile.
    #
    # Required permissions: r_basicprofile, r_fullprofile
    #
    # @see http://developer.linkedin.com/documents/profile-api
    # @macro profile_args
    # @macro multi_profile_options
    def profile(id = {}, options = {})
      options = parse_id(id, options)
      path = profile_path(options)
      get(path, options)
    end

    private ##############################################################


    def parse_id(id, options)
      if id.is_a? String
        if id.downcase =~ /linkedin\.com/
          options[:url] = id
        else
          options[:id] = id
        end
      elsif id.is_a? Hash
        options = id
        # else
        #   options = {}
      end

      return options
    end

  end
end