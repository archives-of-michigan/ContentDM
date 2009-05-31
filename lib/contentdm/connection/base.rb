require 'contentdm/connection/resources'

module ContentDM
  module Connection
    class Base
      include ContentDM::Connection::Resources
      
      attr_accessor :host, :root_path
      
      def initialize(host, root_path = '/cdm_rest', type = :rest, cache_enabled = false)
        case type
        when :rest then
          self.class.rest(host, root_path)
        end
        self.host = host
        self.root_path = root_path
        self.cache_enabled = cache_enabled
      end
      
      def cache_enabled=(val)
        @cache_enabled = val
      end
      def cache_enabled?
        @cache_enabled
      end
      
      class << self
        def rest(host, root_path = '/cdm_rest')
          self.extend(ContentDM::Connection::REST::ClassMethods)
          self.send(:include, ContentDM::Connection::REST::InstanceMethods)
        end
      end
    end
  end
end