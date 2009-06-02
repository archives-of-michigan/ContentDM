require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe ContentDM::Connection::REST do
  describe "initialize" do
    before(:each) do
      @connection = ContentDM::Connection::Base.new('example.com')
    end
  
    describe "request" do
      before(:each) do
        @json = '{"id" : 1}'
        @mock_response = mock(CurbFu::Response, :body => @json, :success? => true)
      end
      
      it 'should fetch collections from a RESTful ContentDM web app' do
        @connection.root_path = nil
        CurbFu.should_receive(:get).with(:host => 'example.com', :path => '/collections.php').and_return(@mock_response)
        
        @connection.request('collections.php')
      end
      
      it 'should return JSON' do
        CurbFu.stub!(:get).and_return(@mock_response)
        
        @connection.request('collections.php').should == @json
      end
      
      it "should append the root_path" do
        @connection.root_path = 'cdm_rest'
        CurbFu.should_receive(:get).with(:host => 'example.com', :path => '/cdm_rest/collections.php').and_return(@mock_response)
        
        @connection.request('collections.php')
      end
      
      it 'should raise ContentDM::Connection::Failed if the web service could not be contacted' do
        failed_response = mock(CurbFu::Response::NotFound, :success? => false)
        CurbFu.stub!(:get).and_return(failed_response)
        
        lambda { @connection.request('collections.php') }.should raise_error(ContentDM::Connection::Failed)
      end
    end
  end
end