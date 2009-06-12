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
            ContentDM::Collection.from_hash(collection)
          end
        end
      end
      
      def collection(c_alias)
        collection = fetch(:collection, :alias => c_alias)
        if !collection.nil?
          ContentDM::Collection.from_hash(collection)
        else
          nil
        end
      end
      
      def search(params)
        items = fetch(:search, params)
        items.collect { |i| ContentDM::Item.from_hash(i) }
      end

      private
        def cache_key(method, params = nil)
          key_text = method.to_s
          
          unless params.nil?
            key_text += params.keys.sort.inject('') do |text, name|
              text += "&#{name}=#{params[name]}"
            end
          end
          
          method.to_s + '/' + Digest::SHA1.hexdigest(key_text)
        end

        def fetch(method, params = {})
          value = nil
          key = cache_key(method, params)
          value = cache.read(key) if cache_enabled?
          if value.nil?
            value = send("fetch_#{method}", params)
            cache.write(key, value) if cache_enabled?
          end
          
          JSON.parse(value)
        end
    end
  end
end