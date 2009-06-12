require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

class TestHarness
  include ContentDM::Connection::AJAJ::InstanceMethods
  
  def host
    'localhost'
  end
  def path_for(p)
    p
  end
end

describe ContentDM::Connection::AJAJ do
  before(:each) do
    @ajaj = TestHarness.new
  end
  describe "request" do
    before(:each) do
      @response = mock(Object, :success? => true, :body => 'win!')
    end
    it "should only send a command if no parameters are given" do
      CurbFu.should_receive(:post).with(anything, { 'command' => 'ctrlaltdel' }).
        and_return(@response)
      
      @ajaj.request('ctrlaltdel')
    end
    it "should send a command and parameters" do
      CurbFu.should_receive(:post).with(anything, { 
        'command' => 'ctrlaltdel',
        'params' => { 'fish' => 'tuna', 'bird' => 'finch' }.to_json }).
        and_return(@response)
      
      @ajaj.request('ctrlaltdel', 'fish' => 'tuna', 'bird' => 'finch')
    end
  end
end