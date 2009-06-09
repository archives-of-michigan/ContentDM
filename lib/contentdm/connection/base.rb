require 'contentdm/connection/resources'

module ContentDM
  module Connection
    class Base
      include ContentDM::Connection::Resources
      
      attr_accessor :host, :root_path, :cache
      
      def initialize(host, root_path = nil, type = :rest, cache = nil)
        case type
        when :rest then
          self.class.rest(host, root_path)
        when :ajaj then
          self.class.ajaj(host, root_path)
        end
        self.host = host
        self.root_path = root_path
        self.cache = cache
      end
      
      def cache_enabled?
        !self.cache.nil?
      end
      
      class << self
        def rest(host, root_path = nil)
          self.extend(ContentDM::Connection::REST::ClassMethods)
          self.send(:include, ContentDM::Connection::REST::InstanceMethods)
        end
        def ajaj(host, root_path = nil)
          self.extend(ContentDM::Connection::AJAJ::ClassMethods)
          self.send(:include, ContentDM::Connection::AJAJ::InstanceMethods)
        end
      end
      
    private
      def path_for(*args)
        first_item = root_path.nil? ? args.shift : root_path
        path = (first_item =~ /^\//) ? first_item : '/' + first_item
        ([path] + args).join('/')
      end
    end
  end
end