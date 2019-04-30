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
    pending("Check after organization API Access")
    VCR.use_cassette("organization data") do
      data = api.organization(id: 11571530)
      expect(data.id).to eq 11571530
      expect(data.name).to eq( {"localized"=>{"en_us"=>"del Nariz Social Media"}, "preferred_locale"=>{"country"=>"US", "language"=>"en"}} )
    end
  end

end
