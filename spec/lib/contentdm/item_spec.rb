require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ContentDM::Item do
  describe "from_hash" do
    it "should create a new item" do
      ContentDM::Item.from_hash('alias' => 'p1234').should be_a_kind_of(ContentDM::Item)
    end
  end
end