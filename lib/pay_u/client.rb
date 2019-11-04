# frozen_string_literal: true

require_relative 'o_auth/authorization'

module PayU
  class Client
    def initialize(configuration, http_client)
      @configuration = configuration
      @http_client = http_client
    end

    def authorize
      authorization.authorize
    end

    private

    def authorization
      OAuth::Authorization.new(@http_client,
                               @configuration.oauth_client_id,
                               @configuration.oauth_client_secret)
    end
  end
end

