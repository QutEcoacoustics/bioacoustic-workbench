require 'spec_helper'

describe AnalysisScript do
  it 'has a valid factory' do
    create(:analysis_script).should be_valid
  end
  it { should belong_to(:user) }


  it { should validate_presence_of(:display_name) }
  it 'is invalid without a display_name' do
    build(:analysis_script, display_name: nil).should_not be_valid
  end
  it 'should ensure the display_name is no more than 255 characters' do
    test_string = Faker::Lorem.characters(256)
    build(:analysis_script, display_name: test_string).should_not be_valid
    build(:analysis_script, display_name: test_string[0..-2]).should be_valid
  end
  it 'should ensure display_name is unique  (case-insensitive)' do
    create(:analysis_script, display_name: 'There ain\'t room enough in this town for two of us sonny!')
    as2 = build(:analysis_script, display_name: 'THERE AIN\'T ROOM ENOUGH IN THIS TOWN FOR TWO OF US SONNY!')
    as2.should_not be_valid
    as2.should have(1).error_on(:name)
  end

  it { should validate_presence_of(:name) }
  it 'is invalid without a name' do
    as           = build(:analysis_script)
    as.force_name= nil
    as.should_not be_valid
  end
  it { should validate_uniqueness_of(:name) }
  it 'is invalid with a duplicate name (case-insensitive)' do
    create(:analysis_script, name: 'the_same_name')
    as2 = build(:analysis_script, name: 'tHE_Same_naMe')
    as2.should_not be_valid
    as2.should have(1).error_on(:name)
  end
  it 'accepts a file-system compatible \'safe\' name' do
    as = build(:analysis_script)
    as.should be_valid

    as.name = 'aValid_file-name'
    as.should be_valid
  end

  ['/invalid', 'i:nvalid', '!invalid', '+invalid', '\\invalid'].each { |testPath|
    it "does not accept a file-system incompatible name \"#{testPath}\"" do
      as = build(:analysis_script, name: testPath)
      as.should_not be_valid
    end
  }

  it 'will not allow a name that is 256 characters' do
    test_string = Faker::Lorem.characters(256)
    build(:analysis_script, name: test_string).should_not be_valid
  end
  it 'will allow a name that is 255 characters' do
    test_string = Faker::Lorem.characters(256)
    build(:analysis_script, name: test_string[0..-2]).should be_valid
  end

  it 'should convert display_name to name (without leading or trailing characters)' do
    as = build(:analysis_script, {display_name: '!!!i_will_trail_your_character!!!' })
    as.name.should == 'i_will_trail_your_character'
    as.should be_valid
  end
  it 'should convert display_name to name (and convert to lower case)' do
    as = build(:analysis_script, { display_name: 'WHATTHEBANNANNA'})
    as.name.should == 'whatthebannanna'
    as.should be_valid
  end
  it 'should convert display_name to name (and replace non-legal symbols with underscore)' do
    as = build(:analysis_script, { display_name: '"FRACK IT: I\'m over this!" Said Apollo to acting-Admiral Adama' })
    as.name.should == 'frack_it_I_m_over_this_said_apollo_to_acting-admiral_adama'
    as.should be_valid
  end

  it 'should allow a user entered name (but still check it it for validity)' do
    as = create(:analysis_script, display_name: 'One bold step for man')
    as.name.should == 'one_bold_step_for_man'
    as.should be_valid

    as.name = 'One giant leap for mankind!'
    as.should_not be_valid

    as.name = 'one_giant_leap_for_mankind'
    as.save!
    as.display_name.should == 'One bold step for man'
    as.name.should =='one_giant_leap_for_mankind'
    as.should be_valid
  end
  it 'should compute a name if only display_name is entered' do
    as = build(:analysis_script, { display_name: "RAWWWWW!!! said the dinosaur", name: nil })
    as.name.should == nil

    # I think it should try and transform somewhere before save
    as.save!
    as.should be_valid
    as.name.should == 'rawwwww_said_the_dinosaur'
  end

  it 'should allow extra_data to be empty' do
    build(:analysis_script, extra_data: nil).should be_valid
  end

  it 'should allow settings to be empty' do
    build(:analysis_script, settings: nil).should be_valid
  end
  it 'should enforce file path restrictions on settings if it is not nil' do
    as = build(:analysis_script, settings: nil)
    as.should be_valid

    as.settings = '/! a really bad: path/somefile.txt'
    as.should_not be_valid

    as.settings = '../a_good_path/and-file.donkey'
    as.should be_valid
  end

  it { should validate_presence_of(:version) }
  it 'should be invalid without a version field specified' do
    build(:analysis_script, version: nil).should_not be_valid
  end

  #it { should validate_presence_of(:verified) }
  it 'should be invalid without a verified field specified' do
    build(:analysis_script, verified: nil).should_not be_valid
  end
  it 'ensures verified can be true or false' do
    as = build(:analysis_script)
    as.should be_valid
    as.verified = true
    as.should be_valid
    as.verified = false
    as.should be_valid
  end
  it 'ensures a new script should have verified set to false' do
    as = AnalysisScript.new
    as.verified.should == false
  end


end