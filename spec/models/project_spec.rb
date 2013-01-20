require 'spec_helper'

describe Project do
  it 'has a valid factory' do
    FactoryGirl.create(:project).should be_valid
  end


  it {should have_many :photos}
  it {should have_many :permissions}
  it {should have_many :sites}
  it {should have_many :project_sites}

  it { should belong_to(:user).with_foreign_key(:creator_id) }

  it 'is invalid without an name' do
    FactoryGirl.build(:project, :name => nil).should_not be_valid
  end
  it 'is invalid without a urn' do
    FactoryGirl.build(:project, :urn => nil).should_not be_valid
  end
  it 'requires unique case-insensitive project names (case insensitive)' do
    p1 = FactoryGirl.create(:project, :name => 'the same name')
    p2 = FactoryGirl.build(:project, :name => 'tHE Same naMe')
    p2.should_not be_valid
    p2.should have(1).error_on(:name)
  end
  it 'requires a unique urn (case insensitive)' do
    p1 = FactoryGirl.create(:project, :urn => 'urn:organisation:project')
    p2 = FactoryGirl.build(:project, :urn => 'urn:organisation:project')
    p2.should_not be_valid
    p2.should have(1).error_on(:urn)
  end
  it 'requires a valid urn' do
    FactoryGirl.build(:project, :urn => 'not a urn').should_not be_valid
  end

end