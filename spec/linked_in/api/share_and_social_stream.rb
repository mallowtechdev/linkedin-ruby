require "spec_helper"

describe LinkedIn::ShareAndSocialStream do
  let(:access_token) { "dummy_access_token" }
  let(:api) { LinkedIn::API.new(access_token) }

  def stub(url)
    stub_request(:get, url).to_return(body: '{}')
  end

  it "should be able to share a new status" do
    stub_request(:post, 'https://api.linkedin.com/v2/shares').to_return(body: '', status: 201)
    response = api.share(comment: 'Testing, 1, 2, 3')
    expect(response.status).to eq 201
    expect(response.body).to eq ''
  end

end
