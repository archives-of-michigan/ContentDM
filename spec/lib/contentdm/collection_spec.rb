require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ContentDM::Collection do
  describe "from_rest_hash" do
    it 'should convert a hash retrieved from the REST interface into a Collection' do
      collection = ContentDM::Collection.from_rest_hash({
        "alias" => "/p4006coll3",
        "name" => "Civil War Photographs",
        "path" => "D:\\Sites\\129401\\Data\\p4006coll3"
      })
      collection.name.should == 'Civil War Photographs'
      collection.alias.should == "/p4006coll3"
    end
  end
  
  describe "alias" do
    it "should trim any leading and trailing whitespace" do
      collection = ContentDM::Collection.new(:alias => ' /p23ann45  ')
      collection.alias.should == '/p23ann45'
    end
  end
end