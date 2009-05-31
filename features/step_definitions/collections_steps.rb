When /^I request all collections$/ do
  @contentdm = ContentDM.connect('example.com', 'cdm_rest')
  @collections = @contentdm.collections
end

Then /^I should have the full list of collections$/ do
  @collections.should == CurbFu.stubs['example.com'].app.collections
end