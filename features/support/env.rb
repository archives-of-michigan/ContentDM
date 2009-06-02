$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
require 'contentdm'
require 'spec/expectations'

require File.join(File.dirname(__FILE__),'rest_server')

CurbFu.stubs = {
  'example.com' => RestServer.new
}