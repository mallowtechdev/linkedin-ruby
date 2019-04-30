require 'spec_helper'

describe LinkedIn::People do

  let(:access_token) {"AQUb8REc0NLIzDyHSd4tIvyGlZ4WEd1Lsb1XoYOCKYu44U3oNRFJT61n2xb1UDR7wKj5OM2NAenTkZrCpUcovO2queOgv95TSyd6U47biDtFN07qVQCay0onN48L_lXOAP_xJQKS1wYWnvNW5k10v9-eiecyofftOh-Auo-8SKs4SmPGAdqv1AppmKpAMpMFK9pfwRVEBmPCwCLcwtLcE0tA15Lj9bnaNJuSpjt9XdvMYAnLQiYIamKX5Nu0nkjVhbQbnHQI_v6g4PyAcgBulOs0WLkwj1yJ89DTF2aGeFLcJItxas_E8ETAK3SD_VBT4sInVQL9ZRQ_B7vVPz7YK0dwCJHKVQ"}

  let(:api) {LinkedIn::API.new(access_token)}

  def verify(result)
    expect(result).to be_kind_of LinkedIn::Mash
  end

  ###### PROFILES
  # Self
  it "grabs your own profile" do
    pending('Need profile API access')
    VCR.use_cassette("people profile own") do
      result = api.profile
      verify result
      expect(result["id"]).to be_kind_of String
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
