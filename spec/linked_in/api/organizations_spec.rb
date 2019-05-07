require "spec_helper"

describe LinkedIn::Organizations do
  let(:access_token) {"dummy access token"}
  let(:api) {LinkedIn::API.new(access_token)}

  def stub(url)
    stub_request(:get, url).to_return(body: '{}')
  end

  it "should be able to view an organization profile" do
    stub("https://api.linkedin.com/v2/organizations/1586")
    expect(api.organization(id: 1586)).to be_an_instance_of(LinkedIn::Mash)
  end

  it "should be able to view an organization by vanity name" do
    stub("https://api.linkedin.com/v2/organizations?q=vanityName&vanityName=acme")
    expect(api.organization(vanity_name: "acme")).to be_an_instance_of(LinkedIn::Mash)
  end

  it "should be able to view an organization by e-mail domain" do
    stub("https://api.linkedin.com/v2/organizations?q=emailDomain&emailDomain=acme.com")
    expect(api.organization(email_domain: "acme.com")).to be_an_instance_of(LinkedIn::Mash)
  end

  it "should load correct organization data" do
    VCR.use_cassette("organization data") do
      data = api.organization(id: 14418463)
      expect(data.id).to eq 14418463
      expect(data.vanity_name).to eq( "test-app-2")
    end
  end

end
