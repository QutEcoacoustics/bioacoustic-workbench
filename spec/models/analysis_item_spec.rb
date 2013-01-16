require 'spec_helper'


describe AnalysisItem do
  it 'has a valid factory' do
    ai = create(:analysis_item)

    ai.should be_valid
  end
  it {should belong_to(:audio_recording)}
  it {should belong_to(:analysis_job)}

  it {should validate_presence_of(:offset_start_seconds)}
  it {should validate_numericality_of(:offset_start_seconds)}
  it 'is invalid without a offset_start_seconds' do
    build(:analysis_item, offset_start_seconds: nil).should_not be_valid
  end
  it 'is invalid with a offset_start_seconds less than zero' do
    build(:analysis_item, offset_start_seconds: -1).should_not be_valid
  end
  it 'is invalid if the offset_end_seconds is less than the offset_start_seconds' do
    build(:analysis_item, {offset_start_seconds: 100.320, offset_end_seconds: 10.360}).should_not be_valid
  end

  it {should validate_presence_of(:offset_end_seconds)}
  it {should validate_numericality_of(:offset_end_seconds)}


  it {should validate_presence_of(:audio_recording_id)}

  it 'should allow blank for worker_started_utc' do
    build(:analysis_item, worker_started_utc: nil).should be_valid
  end
  it 'should not have a worker_started_utc date that is in the future' do
    build(:analysis_item, :worker_started_utc => 1.minute.from_now ).should_not be_valid
  end

  it { should ensure_inclusion_of(:status).in_array([:ready, :running, :complete, :error]) }
  it {should validate_presence_of(:status)}
  it 'should be invalid without a status' do
    build(:analysis_item, status: nil).should_not be_valid
  end
end