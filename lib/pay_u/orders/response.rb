require 'json'

module PayU
  module Orders
    class Response
      def initialize(response)
        @response = response
        @body = JSON.parse(response.body)
      end

      def code
        @response.code
      end

      def success?
        status.success?
      end

      def status
        Status.new(@body['status'])
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

      class Status
        SUCCESS_STATUS = 'SUCCESS'

        def initialize(status)
          @status = status
        end

        def success?
          status_code == SUCCESS_STATUS
        end

        def status_code
          @status['statusCode']
        end

        def code_literal
          @status['codeLiteral']
        end

        def code
          @status['code']
        end
      end
    end
  end
end

