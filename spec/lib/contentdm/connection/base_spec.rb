require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe ContentDM::Connection::Base do
  describe "initialize" do
    before(:each) do
      @connection = ContentDM::Connection::Base.new('example.com')
    end
    it "should create a REST connection" do
      @connection.should be_a_kind_of(ContentDM::Connection::REST::InstanceMethods)
    end
    it "should set the host attribute" do
      @connection.host.should == 'example.com'
    end
    it "should set the root_path attribute" do
      @connection.root_path.should == '/cdm_rest'
    end
  end
end