require 'spec_helper'

describe "AudioRecordingsControllers" do
  describe "GET /audio_recordings_controllers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get "/AudioRecordings"
      response.status.should be(200)
    end
  end
end
