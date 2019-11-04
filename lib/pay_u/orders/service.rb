require_relative 'response'

module PayU
  module Orders
    class Service
      ENDPOINT = "/api/v2_1/orders"

      def initialize(authorization, http_client, default_order_params)
        @authorization = authorization
        @http_client = http_client
        @default_order_params = default_order_params
      end

      def place_order(buyer, products, total_amount, meta = {})
        meta = camelize_keys(meta)
        buyer = camelize_keys(buyer)
        products = camelize_array(products)
        default_order_params = camelize_keys(@default_order_params)
        order_params = default_order_params.merge(buyer: buyer, products: products, totalAmount: total_amount)
        Orders::Response.new(@http_client.post(ENDPOINT, order_params.merge(meta), headers))
      end

      private

      def camelize_array(array)
        array.map do |element|
          camelize_keys(element)
        end
      end

      def camelize_keys(hash)
        camelized_hash = {}
        hash.each_pair do |key, value|
          camelized_hash[camelize_key(key, false)] = value
        end
        camelized_hash
      end

      def camelize_key(key, capitalize)
        index = capitalize ? 0 : 1
        stringified_key = key.to_s
        stringified_key.split('_').each_with_index.map do |str, i|
          index <= i ? str.capitalize : str
        end.join('').to_sym
      end

      def headers
        { "Authorization" => "Bearer #{@authorization.access_token}" }
      end
    end
  end
end

