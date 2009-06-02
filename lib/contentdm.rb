$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'contentdm/collection'
require 'contentdm/item'
require 'contentdm/compound_item'
require 'contentdm/connection'

module ContentDM
  class << self
    def connect(host, root_path, type = :rest)
      ContentDM::Connection::Base.new(host, root_path, type)
    end
  end
end