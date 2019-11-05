module PayU
  class BaseRequest
    def initialize(headers, json_params = {})
      @headers = headers
      @keys = []
      json_params.each_pair do |key, value|
        @keys << key
        define_singleton_method(key) do
          value
        end
      end
    end

    attr_reader :headers

    def to_h
      result = {}
      @keys.each do |key|
        result.merge!(camelize_key(key, false) => camelized_value(send(key)))
      end
      result
    end

    def to_json
      to_h.to_json
    end

    private

    def camelized_value(value)
      if value.respond_to?(:each_pair)
        camelize_keys(value)
      elsif value.respond_to?(:each)
        camelize_array(value)
      else
        value
      end
    end

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
  end
end

