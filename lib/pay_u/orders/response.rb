module PayU
  module Orders
    class Response
      def initialize(response_body)
        @response_body = response_body
      end

      def success?
        status['statusCode'] == 'SUCCESS'
      end

      def status
        @response_body['status']
      end

      def redirect_url
        @response_body['redirectUri']
      end

      def order_id
        @response_body['orderId']
      end

      def ext_order_id
        @response_body['extOrderId']
      end
    end
  end
end

