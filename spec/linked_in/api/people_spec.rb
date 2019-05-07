require 'spec_helper'

describe LinkedIn::People do

  let(:access_token) {"dummy access token"}

  let(:api) {LinkedIn::API.new(access_token)}

  def verify(result)
    expect(result).to be_kind_of LinkedIn::Mash
  end

  ###### PROFILES
  # Self
  it "grabs your own profile" do
    VCR.use_cassette("people profile own") do
      result = api.profile
      verify result
      expect(result["id"]).to eq('test')
    end
  end

  # Errors
  it "errors on bad input" do
    expect{api.profile("Bad input")}.to raise_error
  end
  it "errors on email deprecation" do
    msg = LinkedIn::ErrorMessages.deprecated
    expect{api.profile(email: "email@email.com")}.to raise_error(LinkedIn::Deprecated, msg)
  end

end
