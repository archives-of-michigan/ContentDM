require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ContentDM::Search do
  describe "browse_collection" do
    it "should set up search params for browsing a collection" do
      s = ContentDM::Search.browse_collection('p1234')
      params = s.hash_for_remote
      params.should include('alias' => ['p1234'])
      params.should include('maxrecs' => 20)
    end
    it "should set up search params for browsing a given page of a collection" do
      s = ContentDM::Search.browse_collection('p1234',12)
      params = s.hash_for_remote
      params.should include('alias' => ['p1234'])
      params.should include('start' => 221)
      params.should include('maxrecs' => 20)
    end
  end
  
  describe "results" do
    before(:each) do
      @connection = mock(Object)
      @search = ContentDM::Search.new
      @connection.stub!(:search).
        and_return([ContentDM::Item.new, ContentDM::Item.new])
    end
    it "should fetch results from the server" do
      @connection.should_receive(:search)
      
      @search.results(@connection)
    end
    it "should create an array of items from the results" do
      @search.results(@connection).each do |item|
        item.should be_a_kind_of(ContentDM::Item)
      end
    end
  end
end