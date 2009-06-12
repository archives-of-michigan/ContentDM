require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

class TestHarness
  include ContentDM::Connection::Resources
  
  attr_accessor :host, :path, :cache
  
  def initialize
    host = 'example.com'
    path = '/test'
  end
  
  def cache_enabled?
    false
  end
  
  def fetch(*args)  # test interface to private method #fetch
    super(*args)
  end
  
  def cache_key(*args)  # test interface to private method #cache_key
    super(*args)
  end
  
  def fetch_collections(params)
    '{"id" : 1}'
  end
end

describe ContentDM::Connection::Resources do
  before(:each) do
    @resources = TestHarness.new
    @mock_cache = mock(Object, :write => nil, :read => nil)
    @resources.stub!(:cache).and_return(@mock_cache)
  end
  describe "collections" do
    it "should fetch data from the cache/storage resource" do
      @resources.should_receive(:fetch).with(:collections)
      
      @resources.collections
    end
    it 'should return an array of Collection objects' do
      @resources.stub!(:fetch).and_return([{}, {}])
      @resources.collections.each do |collection|
        collection.should be_a_kind_of(ContentDM::Collection)
      end
    end
  end
  
  describe "cache_key" do
    it 'should return a key for just a method name' do
      Digest::SHA1.stub!(:hexdigest).and_return('cd3f66e2f09f1685d1e2a95a5acd9be8f1aca97a')
      
      @resources.cache_key(:method_name).
        should == 'method_name/cd3f66e2f09f1685d1e2a95a5acd9be8f1aca97a'
    end
    it 'should return a key for a method and its parameters' do
      Digest::SHA1.stub!(:hexdigest).and_return('76a4ebd2a0b4bfb6274af1992f8c30106a42f882')
      
      @resources.cache_key(:method_name, 'color' => 'red', 'weight' => '2231').
        should == 'method_name/76a4ebd2a0b4bfb6274af1992f8c30106a42f882'
    end
  end
  
  describe "fetch" do
    it "should load the data from cache if caching is enabled and cache contains data" do
      @resources.stub!(:cache_enabled?).and_return(true)
      @resources.cache.should_receive(:read).and_return("{ \"test\": \"data\" }")
      
      @resources.fetch(:collections)
    end
    it "should fetch the data from the loaded plugin if caching is enabled and cache is empty" do
      @resources.stub!(:cache_enabled?).and_return(true)
      @resources.cache.stub!(:get)
      @resources.should_receive(:fetch_item).with({ :itnum => 34 }).and_return('{}')
      
      @resources.fetch(:item, :itnum => 34)
    end
    it "should fetch the data from the loaded plugin if caching is disabled" do
      @resources.should_receive(:fetch_item).with({ :itnum => 34 }).
        and_return("{ \"id\": 1 }")
      
      @resources.fetch(:item, :itnum => 34)
    end
    it "should parse the cached/fetched data as JSON" do
      json = '{ "alias" : 1234, "Title" : "Civil War" }'
      @resources.stub!(:fetch_collections).
        and_return(json)
      JSON.should_receive(:parse).with(json).and_return({'alias' => 1234, 'Title' => 'Civil War'})
      
      @resources.fetch(:collections, :alias => '/p1234').
        should == { 'alias' => 1234, 'Title' => 'Civil War' }
    end
    it "should return a ruby array/hash" do
      @resources.stub!(:fetch_collections).
        and_return('{ "alias" : 1234, "Title" : "Civil War" }')
      
      @resources.fetch(:collections, :alias => '/p1234').
        should == { 'alias' => 1234, 'Title' => 'Civil War' }
    end
  end
end