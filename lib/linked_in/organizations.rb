module LinkedIn
  # Organizations API
  #
  # @see https://developer.linkedin.com/docs/guide/v2/organizations
  #
  # [(contribute here)](https://github.com/mallowtechdev/linkedin-ruby)
  class Organizations < APIResource
    # Retrieve an Organization
    #
    # @see https://developer.linkedin.com/docs/guide/v2/organizations/organization-lookup-api
    #
    # @macro organization_path_options
    # @option options [String] :scope
    # @option options [String] :type
    # @option options [String] :count
    # @option options [String] :start
    # @return [LinkedIn::Mash]
    def organization(options = {})
      path = organization_path(options)
      get(path, options)
    end

    # Retrieve Organization Access Control informaion
    #
    # @see https://developer.linkedin.com/docs/guide/v2/organizations/organization-lookup-api#acls
    #
    def organization_acls(options = {})
      path = '/organizationalEntityAcls'
      get(path, options)
    end

    private ##############################################################


    def organization_path(options)
      path = '/organizations'

      if email_domain = options.delete(:email_domain)
        path += "?q=emailDomain&emailDomain=#{CGI.escape(email_domain)}"
      elsif id = options.delete(:id)
        path += "/#{id}"
      elsif urn = options.delete(:urn)
        path += "/#{urn_to_id(urn)}"
      elsif vanity_name = options.delete(:vanity_name)
        path += "?q=vanityName&vanityName=#{CGI.escape(vanity_name)}"
      else
        path += "/me"
      end
    end

  end
end
