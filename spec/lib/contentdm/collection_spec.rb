require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ContentDM::Collection do
  describe "all" do
    
  end
  describe "find_by_alias" do
    
  end
  describe "alias" do
    it "should trim any leading and trailing whitespace" do
      collection = ContentDM::Collection.new(:alias => ' /p23ann45  ')
      collection.alias.should == '/p23ann45'
    end
  end
end