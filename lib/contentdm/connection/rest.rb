require 'curb-fu'
require 'uri'

module ContentDM
  module Connection
    module REST
      module ClassMethods
        
      end
      
      module InstanceMethods
        def fetch_collections(params = nil)
          request('collections.php')
        end
        
        def fetch_collection(c_alias = '')
          request('collections.php', :alias => c_alias)
        end
        
        def request(path, params = {})
          response = CurbFu.get({ :host => host, :path => path_for(path) }, params)
          
          if response.success?
            response.body
          elsif response.is_a?(CurbFu::Response::NotFound)
            raise ContentDM::Connection::NotFound
          else
            raise ContentDM::Connection::Failed
          end
        end
      end
    end
  end
end