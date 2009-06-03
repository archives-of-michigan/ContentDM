require 'digest/sha1'
require 'json'

module ContentDM
  module Connection
    module Resources
      def collections
        all_collections = fetch(:collections)
        if all_collections.nil?
          []
        else
          all_collections.collect do |collection|
            ContentDM::Collection.from_rest_hash(collection)
          end
        end
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
          value = cache.get(cache_key(method, params)) if cache_enabled?
          if value.nil?
            value = send("fetch_#{method}", params)
            cache.set(value) if cache_enabled?
          end
          
          JSON.parse(value)
        end
    end
  end
end