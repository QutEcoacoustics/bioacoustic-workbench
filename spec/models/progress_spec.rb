require 'spec_helper'

describe Progress do
  it 'has a valid factory' do
    create(:progress).should be_valid
  end

  it { should belong_to(:saved_search) }
  it { should belong_to(:audio_recording) }
  it { should belong_to(:user).with_foreign_key(:creator_id) }


  it { should validate_presence_of(:activity) }
  it 'is invalid without a activity' do
    build(:progress, activity: nil).should_not be_valid
  end

  it { should validate_presence_of(:offset_list) }
  it 'is invalid without a offset_list' do
    build(:progress, offset_list: nil).should_not be_valid
  end

  it { should validate_presence_of(:saved_search_id) }
  it { should validate_presence_of(:audio_recording_id) }
  it { should validate_presence_of(:creator_id) }

  it { should validate_presence_of(:start_offset_seconds) }
  it { should validate_numericality_of(:start_offset_seconds) }
  it 'is invalid without a start_offset_seconds' do
    build(:progress, start_offset_seconds: nil).should_not be_valid
  end
  it 'is invalid with a start_offset_seconds less than zero' do
    build(:progress, start_offset_seconds: -1).should_not be_valid
  end
  it 'is invalid if the offset_end_seconds is less than the offset_start_seconds' do
    build(:progress, { start_offset_seconds: 100.320, end_offset_seconds: 10.360 }).should_not be_valid
  end

  it { should validate_presence_of(:end_offset_seconds) }
  it { should validate_numericality_of(:end_offset_seconds) }


  context 'pseudo composite key testing (via uniqueness constraint)' do
    before(:all) do
      @ss1 = create(:saved_search)
      @ss2 = create(:saved_search)

      @u1 = create(:user)
      @u2 = create(:user)

      @ar1 = create(:audio_recording)
      @ar2 = create(:audio_recording)

    end


    it 'should ensure the test symbols are not the same' do
      @ss1.should_not == @ss2

      @u1.should_not ==@u2

      @ar1.should_not == @ar2
    end


    test_cases = [
        {
            a:     ['hello', '@ss1', '@ar1', 30.5, 360, '@u1'],
            b:     ['HELLO', '@ss1', '@ar1', 30.5, 360, '@u1'],
            valid: false
        },
        {
            a:     ['hello', '@ss1', '@ar1', 30.5, 360, '@u1'],
            b:     ['hello world', '@ss1', '@ar1', 30.5, 360, '@u1'],
            valid: true
        },
        {
            a:     ['hello', '@ss1', '@ar1', 30.5, 360, '@u1'],
            b:     ['hello', '@ss2', '@ar1', 30.5, 360, '@u1'],
            valid: true
        },
        {
            a:     ['hello', '@ss1', '@ar1', 30.5, 360, '@u1'],
            b:     ['hello', '@ss1', '@ar2', 30.5, 360, '@u1'],
            valid: true
        },
        {
            a:     ['hello', '@ss1', '@ar1', 30.5, 360, '@u1'],
            b:     ['hello', '@ss1', '@ar1', 60, 360, '@u1'],
            valid: true
        },
        {
            a:     ['hello', '@ss1', '@ar1', 30.5, 360, '@u1'],
            b:     ['hello', '@ss1', '@ar1', 30.5, 520, '@u1'],
            valid: true
        },
        {
            a:     ['hello', '@ss1', '@ar1', 30.5, 360, '@u1'],
            b:     ['hello', '@ss1', '@ar1', 30.5, 360, '@u2'],
            valid: true
        },
    ]
    test_cases.each { |test_case|

      it "should #{'not' unless test_case[:valid]} allow two record to be created: a:`#{test_case[:a]}` and b:`#{test_case[:b]}`" do
        a = test_case[:a]
        b = test_case[:b]

        create(:progress, { activity: a[0], saved_search: (eval a[1]), audio_recording: (eval a[2]), start_offset_seconds: a[3], end_offset_seconds: a[4], creator: (eval a[5]) })
        b_obj = build(:progress, { activity: b[0], saved_search: (eval b[1]), audio_recording: (eval b[2]), start_offset_seconds: b[3], end_offset_seconds: b[4], creator: (eval b[5]) })

        b_obj.send(test_case[:valid] ? 'should' : 'should_not', be_valid)
      end

    }
  end

end