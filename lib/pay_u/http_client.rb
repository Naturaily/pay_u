require 'net/http'
require 'uri'
require 'json'

module PayU
  class HttpClient
    DEFAULT_HEADER = { "Content-Type" => "application/json" }

    def initialize(host)
      @host = formatted_url(host)
    end

    def post_form(path, params)
      response = Net::HTTP.post_form(uri(path), params)
      parse_json(response.body)
    end

    def post(path, params, headers = {})
      response = Net::HTTP.post(uri(path), params.to_json, DEFAULT_HEADER.merge(headers))
      parse_json(response.body)
    end

    private

    def parse_json(json_string)
      JSON.parse(json_string)
    end

    def uri(path)
      URI(@host + path)
    end

    def formatted_url(url)
      url.delete_suffix('/')
    end
  end
end


