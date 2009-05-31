require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ContentDM do
  it "should connect to a ContentDM REST interface" do
    ContentDM::Connection::Base.should_receive(:rest).with('www.example.com', '/custom/cdm_rest')
    
    ContentDM.connect('www.example.com', '/custom/cdm_rest', :rest)
  end
  it "should set the connection attribute to a new instance of ContentDM::Connection::Base" do
    cdm = ContentDM.connect('www.example.com', '/custom/cdm_rest', :rest)
    
    cdm.connection.should be_a_kind_of(ContentDM::Connection::Base)
  end
end