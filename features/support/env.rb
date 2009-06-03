$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
require 'contentdm'
require 'contentdm/test'
require 'spec/expectations'

CurbFu.stubs = {
  'example.com' => ContentDM::Test::RestServer.new
}