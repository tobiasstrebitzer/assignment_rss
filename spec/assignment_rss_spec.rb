require 'spec_helper'

describe AssignmentRss do
  it 'should return correct version string' do
    AssignmentRss.version_string.should == "AssignmentRss version #{AssignmentRss::VERSION}"
  end
  
end
