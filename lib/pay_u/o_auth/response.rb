require "pry"

module PayU
  module OAuth
    class Response
      def initialize(response_body)
        @response_body = response_body
      end

      def success?
        @response_body["error"].nil?
      end

      def access_token
        @response_body["access_token"]
      end
    end
  end
end

