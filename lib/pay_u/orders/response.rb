require 'json'
require 'pry'

module PayU
  module Orders
    class Response
      def initialize(response)
        @response = response
        @body = JSON.parse(response.body)
      end

      def success?
        status['statusCode'] == 'SUCCESS'
      end

      def status
        @body['status']
      end

      def redirect_url
        @body['redirectUri']
      end

      def order_id
        @body['orderId']
      end

      def ext_order_id
        @body['extOrderId']
      end
    end
  end
end

