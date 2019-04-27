# Linkedin

Ruby-wrapper for LinkedIn API version 2 with Oauth2 support.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'linkedin-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install linkedin-ruby

## Usage

**[Step 1:](#step-1-register-your-application)** [Register](https://www.linkedin.com/secure/developer) your
 application with LinkedIn. They will give you a **Client ID** (aka API
 Key) and a **Client Secret** (aka Secret Key)
 
 **[Step 2:](#step-2-getting-an-access-token)** Use your **Client ID** and **Client Secret** to obtain an **Access Token** from some user.
 
 **[Step 3:](#step-3-using-linkedins-api)** Use an **Access Token** to query the API.
 
 ```ruby
 api = LinkedIn::API.new(access_token)
 me = api.profile
 ```
 
 ## Step 1: Register your Application
 
 You first need to create and register an application with LinkedIn
 [here](https://www.linkedin.com/secure/developer).
 
 You will not be able to use any part of the API without registering first.
 
 Once you have registered you will need to take note of a few key items on
 your Application Details page.
 
 1. **API Key** - We refer to this as your client id or `client_id`
 1. **Secret Key** - We refer to this as your client secret or
    `client_secret`
 1. **Default Scope** - This is the set of permissions you request from
    users when they connect to your app. If you want to set this on a
    request-by-request basis, you can use the `scope` option with the
    `auth_code_url` method.
 1. **OAuth 2.0 Redirect URLs** - For security reasons, the url you enter
    in this box must exactly match the `redirect_uri` you use in this gem.
 
 You do NOT need **OAuth User Token** nor **OAuth User Secret**. That is
 for OAuth 1.0. This gem is for OAuth 2.0.
 
 ## Step 2: Getting An Access Token
 
 All LinkedIn API requests must be made in the context of an access token.
 The access token encodes what LinkedIn information your AwesomeApp® can
 gather on behalf of "John Doe".
 
 There are a few different ways to get an access token from a user.
 
 1. You can use [LinkedIn's Javascript API](https://developer.linkedin.com/documents/javascript-api-reference-0) to authenticate on the front-end and then pass the access token to the backend via [this procedure](https://developer.linkedin.com/documents/exchange-jsapi-tokens-rest-api-oauth-tokens).
 
 1. If you use OmniAuth, I would recommend looking at [decioferreira/omniauth-linkedin-oauth2](https://github.com/decioferreira/omniauth-linkedin-oauth2) to help automate authentication.
 
 1. You can do it manually using this linkedin-ruby gem and the steps
    below.
 
 Here is how to get an access token using this linkedin-ruby gem:
 
 ### Step 2A: Configuration
 
 You will need to configure the following items:
 
 1. Your **client id** (aka API Key)
 1. Your **client secret** (aka Secret Key)
 1. Your **redirect uri**. On LinkedIn's website you must input a list of
    valid redirect URIs. If you use the same one each time, you can set it
    in the `LinkedIn.configure` block. If your redirect uris change
    depending on business logic, you can pass it into the `auth_code_url`
    method.
 
 ```ruby
 # It's best practice to keep secret credentials out of source code.
 # You can, of course, hardcode dev keys or directly pass them in as the
 # first two arguments of LinkedIn::OAuth2.new
 LinkedIn.configure do |config|
   config.client_id     = ENV["LINKEDIN_CLIENT_ID"]
   config.client_secret = ENV["LINKEDIN_CLIENT_SECRET"]
 
   # This must exactly match the redirect URI you set on your application's
   # settings page. If your redirect_uri is dynamic, pass it into
   # `auth_code_url` instead.
   config.redirect_uri  = "https://example.io/linkedin/oauth2"
 end
 ```
 
 ### Step 2B: Get Auth Code URL
 
 ```ruby
 oauth = LinkedIn::OAuth2.new
 
 url = oauth.auth_code_url
 ```
 
 ### Step 2C: User Sign In
 
 You must now load url from Step 2B in a browser. It will pull up the
 LinkedIn sign in box. Once LinkedIn user credentials are entered, the box
 will close and redirect to your redirect url, passing along with it the
 **OAuth code** as the `code` GET param.
 
 Be sure to read the extended documentation around the LinkedIn::OAuth2
 module for more options you can set.
 
 **Note:** The **OAuth code** only lasts for ~20 seconds!
 
 ### Step 2D: Get Access Token
 
 ```ruby
 code = "THE_OAUTH_CODE_LINKEDIN_GAVE_ME"
 
 access_token = oauth.get_access_token(code)
 ```
 
 Now that you have an access token, you can use it to query the API.
 
 The `LinkedIn::OAuth2` inherits from [intreda/oauth2](https://github.com/intridea/oauth2)'s `OAuth2::Client` class. See that gem's [documentation](https://github.com/intridea/oauth2/blob/master/lib/oauth2/client.rb) for more usage examples.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/linkedin-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Linkedin project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/linkedin-ruby/blob/master/CODE_OF_CONDUCT.md).
