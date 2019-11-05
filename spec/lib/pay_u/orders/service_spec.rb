# frozen_string_literal: true

require 'pay_u/o_auth/authorization'
require 'pay_u/http_client'
require 'pay_u/orders/service'
require 'pay_u/base_request'
require 'securerandom'

RSpec.describe PayU::Orders::Service do
  let(:service) { described_class.new(http_client) }

  let(:authorization) { PayU::OAuth::Authorization.new(http_client, client_id, client_secret) }
  let(:http_client) { PayU::HttpClient.new(host) }
  let(:host) { "https://secure.snd.payu.com/" }
  let(:client_id) { ENV['PAY_U_OAUTH_CLIENT_ID'] }
  let(:client_secret) { ENV['PAY_U_OAUTH_CLIENT_SECRET'] }

  describe '#place_order' do
    subject { service.place_order(request) }
    let(:default_order_params) { { notify_url: 'https://example.com', merchant_pos_id: ENV['PAY_U_POS_ID'] } }
    let(:headers) {
      { "Authorization" => "Bearer #{authorization.access_token}" }
    }
    let(:request) { PayU::BaseRequest.new(headers, options) }
    let(:ext_order_id) { SecureRandom.uuid }

    let(:buyer) do
      {
        email: "john.doe@example.com",
        phone: "654111654",
        first_name: "John",
        last_name: "Doe"
      }
    end
    let(:products) do
      [
        {
          name: "Wireless Mouse for Laptop",
          unit_price: "15000",
          quantity: "1"
        }
      ]
    end
    let(:total_amount) { 15000 }
    let(:meta) do
      {
        customer_ip: "127.0.0.1",
        description: "RTV market",
        currency_code: "PLN",
        ext_order_id: ext_order_id,
      }.merge(default_order_params)
    end
    let(:options) do
      meta.merge(
        {
          buyer: buyer,
          products: products,
          total_amount: total_amount
        }
      )
    end

    it { expect(subject.success?).to be_truthy }
    it { expect(subject.ext_order_id).to eq ext_order_id }
  end
end

