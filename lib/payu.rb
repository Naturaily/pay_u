require "pay_u/version"
require "pay_u/client"
require "pay_u/http_client"

module PayU
  class Error < StandardError; end

  class << self
    attr_accessor :configuration, :client
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    self.client = Client.new(configuration, HttpClient.new(configuration.host))
  end

  class Configuration
    PRODUCTION_ENV_NAME = "production"
    SANDBOX_HOST_URI = "https://secure.snd.payu.com/"
    PRODUCTION_HOST_URI = "https://secure.payu.com/"

    attr_accessor :pos_id, :second_key, :oauth_client_id, :oauth_client_secret, :env, :notify_url

    def initialize
      @env = PRODUCTION_ENV_NAME
    end

    def host
      production? ? PRODUCTION_HOST_URI : SANDBOX_HOST_URI
    end

    def production?
      @env == PRODUCTION_ENV_NAME
    end
  end
end

