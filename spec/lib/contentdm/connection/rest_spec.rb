require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe ContentDM::Connection::REST do
  describe "initialize" do
    before(:each) do
      @connection = ContentDM::Connection::Base.new(:rest)
    end
  
    it "should have an interface to the collections" do
      @connection.collections.should be_a_kind_of(ContentDM::Connection::REST::Collection)
    end
  end
end