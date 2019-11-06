# frozen_string_literal: true

require_relative 'o_auth/authorization'
require_relative 'orders/service'
require_relative 'base_request'

module PayU
  class Client
    def initialize(configuration, http_client)
      @configuration = configuration
      @http_client = http_client
    end

    def authorize
      authorization.authorize
    end

    def place_order(buyer, products, total_amount, meta = {})
      request_hash = order_meta(meta).merge({ buyer: buyer,
                                              products: products,
                                              total_amount: total_amount })

      request = PayU::BaseRequest.new(headers, request_hash)
      orders_service.place_order(request)
    end

    def refund_order(order_id, amount = nil)
      request_hash = { refund: { description: "Refund" } }.merge(refund_amount(amount))
      orders_service.refund_order(order_id, PayU::BaseRequest.new(headers, request_hash))
    end

    def cancel_order(order_id)
      orders_service.cancel_order(order_id, PayU::BaseRequest.new(headers))
    end

    private

    def refund_amount(amount)
      amount.nil? ? {} : { amount: amount }
    end

    def order_meta(meta)
      default_order_params.merge(meta)
    end

    def orders_service
      @orders_service ||= Orders::Service.new(authorization, @http_client, default_order_params)
    end

    def default_order_params
      { notify_url: @configuration.notify_url, merchant_pos_id: @configuration.pos_id }
    end

    def authorization
      @authorization ||= OAuth::Authorization.new(@http_client,
                                                  @configuration.oauth_client_id,
                                                  @configuration.oauth_client_secret)
    end

    def headers
      { "Authorization" => "Bearer #{authorization.access_token}" }
    end
  end
end

