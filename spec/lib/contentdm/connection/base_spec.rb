require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe ContentDM::Connection::Base do
  before(:each) do
    @connection = ContentDM::Connection::Base.new('example.com', 'cdm_rest')
  end
  
  describe "initialize" do
    it "should create a REST connection" do
      @connection.should be_a_kind_of(ContentDM::Connection::REST::InstanceMethods)
    end
    it "should set the host attribute" do
      @connection.host.should == 'example.com'
    end
    it "should set the root_path attribute" do
      @connection.root_path.should == 'cdm_rest'
    end
  end
  
  describe "path_for" do
    it "should prepend the root_path if specified and prepend a slash if none is provided" do
      @connection.root_path = 'cdm_rest'
      @connection.send(:path_for, 'big','red').should == '/cdm_rest/big/red'
    end
    it "should prepend the root_path if specified and not prepend a slash if one is provided" do
      @connection.root_path = '/cdm_rest'
      @connection.send(:path_for,'big','red').should == '/cdm_rest/big/red'
    end
    it "should not prepend a root path and prepend a slash if none is provided" do
      @connection.root_path = nil
      @connection.send(:path_for,'big','red').should == '/big/red'
    end
    it "should not prepend a root path and not prepend a slash if one is provided" do
      @connection.root_path = nil
      @connection.send(:path_for,'/big','red').should == '/big/red'
    end
  end
end