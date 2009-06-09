require 'curb-fu'
require 'uri'

module ContentDM
  module Connection
    module AJAJ
      module ClassMethods
        
      end
      
      module InstanceMethods
        def fetch_collections(params = nil)
          request('get_collections_with_meta_data')
        end
        
        def fetch_collection(c_alias = '')
          request('collection_info', :alias => c_alias)
        end
        
        def request(command, params = {})
          all_params = { 'command' => command }
          all_params.merge('params' => params.to_json)
          response = CurbFu.post({ :host => host, :path => path_for('cdm_server.php') }, all_params)
          
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