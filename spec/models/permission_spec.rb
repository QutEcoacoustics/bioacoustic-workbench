require 'spec_helper'

describe Permission do
  it 'has a valid factory' do
    create(:permission).should be_valid
  end

  it { should belong_to(:user) }
  it { should belong_to(:permissionable) }
  it { should belong_to(:user).with_foreign_key(:creator_id) }

  context 'project permission' do

    it 'should have an attached project' do
      build(:project_permission).permissionable.blank?.should be_false
      build(:project_permission).permissionable.should be_an_instance_of(Project)
    end
    it 'should have set the permissionable_type to project' do
      build(:project_permission).permissionable_type.should == 'Project'
    end
    it 'should have set the permissionable id' do
      build(:project_permission).permissionable_id.should > 0
    end
  end

  it 'is when a user is not specified, it should be anonymous' do
    build(:permission, user: nil).anonymous?.should be_true
  end
  it 'should ensure the default permission is `none`' do
    p = Permission.new
    p.level.should == :none.to_s
    p.none?.should be_true
  end

  levels = [:owner, :writer, :reader, :none]

  levels.each { |permission|
    it "should be valid with the #{permission.to_s} permission is set" do
      build(:permission, level: permission).should be_valid
    end
  }

  levels.each { |permission|
    it "should ensure the enumerize predicates respond correctly when the  #{permission.to_s} permission is set" do
      p = build(:permission, level: permission)

      levels.each { |level|
        p.send(level.to_s + '?').should == (level.to_s == p.level)
      }
    end
  }

  # this is a subset of the relevant combinations
  # see https://github.com/QutBioacousticsResearchGroup/bioacoustic-workbench/wiki/Permission
  # for the full set (missing whether user is logged in or not (auth token))
  context "permission combinations" do
    cases = [
        { level: :owner,  id: true , logged_in: true, valid: true },
        { level: :writer, id: true , logged_in: true, valid: true },
        { level: :reader, id: true , logged_in: true, valid: true },
        { level: :none,   id: true , logged_in: true, valid: true },

        { level: :owner,  id: true , logged_in: false, valid: false },
        { level: :writer, id: true , logged_in: false, valid: false },
        { level: :reader, id: true , logged_in: false, valid: false },
        { level: :none,   id: true , logged_in: false, valid: false },

        { level: :owner,  id: false, logged_in: true, valid: false },
        { level: :writer, id: false, logged_in: true, valid: true },
        { level: :reader, id: false, logged_in: true, valid: true },
        { level: :none,   id: false, logged_in: true, valid: true },

        { level: :owner,  id: false, logged_in: false, valid: false },
        { level: :writer, id: false, logged_in: false, valid: false },
        { level: :reader, id: false, logged_in: false, valid: true },
        { level: :none,   id: false, logged_in: false, valid: true }
    ]

    cases.each{ |test_case|
      it "should be #{'not' unless test_case[:valid]} valid when user is #{'not' unless test_case[:id]} present and user is #{'not' unless test_case[:logged_in]} logged in and permission level is '#{test_case[:level]}'" do
        u = nil
        u = create(:user) if test_case[:id]
        p = build(:permission, {level: test_case[:level], user: u, logged_in:test_case[:logged_in]})
        if test_case[:valid]
          p.should be_valid
        else
          p.should_not be_valid
        end
      end
    }
  end


end