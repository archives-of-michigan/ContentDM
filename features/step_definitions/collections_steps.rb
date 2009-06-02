When /^I request all collections$/ do
  @contentdm = ContentDM.connect('example.com', 'cdm_rest')
  @collections = @contentdm.collections
end

Then /^I should have the full list of collections$/ do
  @collections.should be_a_kind_of(Array)
  @collections.length.should == 13
  @collections.each do |collection|
    collection.should be_a_kind_of(ContentDM::Collection)
  end
end