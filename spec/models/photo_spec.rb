require 'spec_helper'

describe Photo do
  it 'has a valid factory' do
    create(:photo).should be_valid
  end

  it { should belong_to(:imageable) }

  context 'project image' do

    it 'should have an attached project' do
      build(:project_photo).imageable.blank?.should be_false
      build(:project_photo).imageable.should be_an_instance_of(Project)
    end
    it 'should have set the imageable type to project' do
      build(:project_photo).imageable_type.should == 'Project'
    end
    it 'should have set the imageable id' do
      build(:project_photo).imageable_id.should > 0
    end
  end

  context 'site image' do

    it 'should have an attached project' do
      build(:site_photo).imageable.blank?.should be_false
      build(:site_photo).imageable.should be_an_instance_of(Site)
    end
    it 'should have set the imageable type to project' do
      build(:site_photo).imageable_type.should == 'Site'
    end
    it 'should have set the imageable id' do
      build(:site_photo).imageable_id.should > 0
    end
  end

  it { should validate_presence_of(:uri) }
  it 'is invalid without a uri' do
    build(:photo, :uri => nil).should_not be_valid
  end

  uri_cases = [
      ['rabbits', false],
      ['/assets/relative/path.jpg', false],
      ['http://www.fully.qualified.com/', true],
      ['https://www.fully.qualified.com/', true],
      ['http://www.fully.qualified.com/image.jpg', true],
      ['https://www.fully.qualified.com/image.jpg', true],
      ['ftp://www.fully.qualified.com/image.jpg', false]
  ]
  uri_cases.each { |test_case|
    it "should #{'not' unless test_case[1]} be valid with the uri: #{test_case[0]}" do
      build(:photo, uri: test_case[0]).send(test_case[1] ? 'should': 'should_not', be_valid)
    end
  }


  it { should validate_presence_of(:copyright) }
  it 'is invalid without a uri' do
    build(:photo, :copyright => nil).should_not be_valid
  end

end