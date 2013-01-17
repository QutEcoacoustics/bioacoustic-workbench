require 'spec_helper'


describe User do
  it 'has a valid factory' do
    u = create(:user)

    u.should be_valid
  end


  it { should have_many(:projects) }
  it { should have_many(:sites) }
  it { should have_many(:audio_recordings)}
  it { should have_many(:audio_events) }
  it { should have_many(:tags)}
  it { should have_many(:audio_event_tags)}
  it { should have_many(:permissions_created).with_foreign_key(:creator_id) }
  it { should have_many(:permissions) }
  it { should have_many(:analysis_scripts)}
  it { should have_many(:analysis_jobs)}
  it { should have_many(:progresses) }
  it { should have_many(:bookmarks) }
  it { should have_many(:saved_searches) }
  it { should have_many(:authorizations) }

  it { should validate_presence_of(:user_name) }
  it 'is invalid without a user_name' do
    build(:user, user_name: nil).should_not be_valid
  end
  it { should validate_uniqueness_of(:user_name) }
  it 'is invalid with a duplicate user_name (case-insensitive)' do
    create(:user, user_name: 'the_same name')
    u = build(:user, user_name: 'tHE_Same naMe')
    u.should_not be_valid
    u.should have(1).error_on(:user_name)
  end
  restricted_user_names = %w(admin harvester analysis_runner)
  it { should ensure_exclusion_of(:user_name).in_array(restricted_user_names) }
  restricted_user_names.each { |special_name|
    it "should ensure username cannot be set to #{special_name}" do
      build(:user, user_name: special_name).should_not be_valid
    end
    it "should ensure username can be set to #{special_name} (if set_user_name_exclusion_list is true)" do
      u                               = build(:user)
      u.skip_user_name_exclusion_list = true
      u.user_name                     =special_name
      u.should be_valid
    end

  }

  it 'is invalid with a duplicate display_name (case-insensitive)' do
    create(:user, display_name: 'the_same name')
    u = build(:user, display_name: 'tHE_Same naMe')
    u.should_not be_valid
    u.should have(1).error_on(:display_name)
  end

  it { should validate_presence_of(:email) }
  it 'is invalid with a duplicate email (case-insensitive)' do
    u1 = create(:user, email: 'the_same+email@anthony.is.AWESOME')
    u = build(:user, email: 'tHE_same+eMAIl@Anthony.IS.awesome')
    u.should_not be_valid
    u.should have(1).error_on(:email)
  end
  context 'basic email syntax checking' do
    emails = [
        ['example@dooby.com', true],
        ['example@dooby', false],
        ['@dooby.com', false],
        ['example.dooby.com', false],
        ['lololololol', false],
        ['example@dooby.com.au', true],
        ['@.', false],
        ['.', false],
        ['@', false]
    ]
    emails.each { |email_case|
      email = email_case[0]
      pass  = email_case[1]
      it "should #{'not' if !pass} allow this '#{email}' email address" do
        if pass
          build(:user, email: email).should be_valid
        else
          build(:user, email: email).should_not be_valid
        end
      end

    }
  end

  context 'display_name is optional if an email is provided are required to be valid' do
    it 'should NOT allow just display_name (email is always requried)' do
      u = build(:user, { display_name: 'Barney Stinson', email: nil })
      u.should_not be_valid
    end
    it 'should allow just email' do
      build(:user, { display_name: nil, email: 'barney@thebrocode.org' }).should be_valid
    end
    it 'should allow display_name and email address (at the same time)' do
      build(:user, { display_name: 'Barney Stinson', email: 'barney@thebrocode.org' }).should be_valid
    end
    it 'should should not allow empty display_name and email fields' do
      build(:user, { display_name: nil, email: nil }).should_not be_valid
    end
  end


end
