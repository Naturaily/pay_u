# frozen_string_literal: true

require 'pay_u/http_client'

RSpec.describe PayU::Client do
  let(:client) { described_class.new(configuration, http_client) }
  let(:http_client) { PayU::HttpClient.new(host) }
  let(:host) { "https://secure.snd.payu.com/" }
  let(:configuration) do
    double(
      :configuration,
      pos_id: ENV['PAY_U_POS_ID'],
      oauth_client_id: ENV['PAY_U_OAUTH_CLIENT_ID'],
      oauth_client_secret: ENV['PAY_U_OAUTH_CLIENT_SECRET'],
      notify_url: "https://example.com"
    )
  end

  describe "#authorize" do
    subject { client.authorize }

    it { expect(subject.success?).to be_truthy }
  end
end

