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
        
        def request(*args)
          response = CurbFu.get(:host => host, :path => path_for(*args))
          
          if response.success?
            response.body
          else
            raise ContentDM::Connection::Failed
          end
        end
      end
    end
  end
end