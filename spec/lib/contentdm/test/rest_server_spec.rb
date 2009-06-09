require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')
require 'contentdm/test'
require 'json'

describe ContentDM::Test::RestServer do
  before(:all) do
    @app = ContentDM::Test::RestServer.new
    CurbFu.stubs = { 'example.com' => @app }
  end
  
  describe "GET /collections.php" do
    it "should return a list of collections" do
      result = CurbFu.get('http://example.com/collections.php')
      ary = JSON.parse(result.body)
      
      ary.length.should == 13
    end
  end
  
  describe "GET /collections.php?alias=p4006coll2" do
    it "should return a single collection" do
      result = CurbFu.get('http://example.com/collections.php', :alias => 'p4006coll2')
      hsh = JSON.parse(result.body)
      hsh['alias'].should == '/p4006coll2'
    end
    it "should return a single collection when CurbFu.get is used with hash" do
      result = CurbFu.get({ :host => 'example.com', :path => '/collections.php' }, :alias => 'p4006coll2')
      hsh = JSON.parse(result.body)
      hsh['alias'].should == '/p4006coll2'
    end
  end
end