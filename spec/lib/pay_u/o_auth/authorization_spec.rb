# frozen_string_literal: true

require 'pay_u/o_auth/authorization'
require 'pay_u/http_client'

RSpec.describe PayU::OAuth::Authorization do
  let(:authorization) { described_class.new(http_client, client_id, client_secret) }

  let(:http_client) { PayU::HttpClient.new(host) }
  let(:host) { "https://secure.snd.payu.com/" }
  let(:client_id) { ENV['PAY_U_OAUTH_CLIENT_ID'] }
  let(:client_secret) { ENV['PAY_U_OAUTH_CLIENT_SECRET'] }

  describe '#authorize' do
    subject { authorization.authorize }

    it { expect(subject.success?).to be_truthy }
  end
end

