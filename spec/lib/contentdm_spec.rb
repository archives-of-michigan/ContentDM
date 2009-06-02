require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ContentDM do
  it "should connect to a ContentDM REST interface" do
    ContentDM::Connection::Base.should_receive(:rest).with('www.example.com', '/custom/cdm_rest')
    
    ContentDM.connect('www.example.com', '/custom/cdm_rest', :rest)
  end
end