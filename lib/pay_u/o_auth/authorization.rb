require_relative "response"

module PayU
  module OAuth
    class UnauthorizedError < StandardError; end

    class Authorization
      GRANT_TYPE = "client_credentials"
      ENDPOINT = "/pl/standard/user/oauth/authorize"

      def initialize(http_client, client_id, client_secret)
        @http_client = http_client
        @client_id = client_id
        @client_secret = client_secret
      end

      def access_token
        response = authorize
        raise UnauthorizedError unless response.success?
        authorize.access_token
      end

      def authorize
        OAuth::Response.new(fetch_response)
      end

      private

      def fetch_response
        @http_client.post_form(ENDPOINT, authorization_options)
      end

      def authorization_options
        { grant_type: GRANT_TYPE, client_id: @client_id, client_secret: @client_secret }
      end
    end
  end
end

