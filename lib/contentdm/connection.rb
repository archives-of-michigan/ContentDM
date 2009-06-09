require 'contentdm/connection/base'
require 'contentdm/connection/rest'
require 'contentdm/connection/ajaj'

module ContentDM
  module Connection
    class Failed < StandardError; end
    class NotFound < StandardError; end
  end
end