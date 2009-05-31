require 'digest/sha1'
require 'json'

module ContentDM
  module Connection
    module Resources
      def collections
        fetch(:collections)
      end

      private
        def cache_key(method, params = nil)
          key_text = method.to_s
          
          unless params.nil?
            key_text += params.keys.sort.inject('') do |text, name|
              text += "&#{name}=#{params[text]}"
            end
          end
          
          method.to_s + '/' + Digest::SHA1.hexdigest(key_text)
        end
      
        def fetch(method, params = {})
          value = cache.get(cache_key(method, params))
          return value unless value.nil?
          
          value = send("fetch_#{method}".to_sym, params)
          cache.set(value)
          JSON.parse(value)
        end
    end
  end
end