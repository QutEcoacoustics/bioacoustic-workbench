Given /I am using an audio file located at "(.*)"/ do |path|
  @audio_file = path
end

When /I request the audio file information/ do
  @audio_info = Audio.info @audio_file
end

Then /I should get information about the file/ do

end

Then /The length of the file should be (.*) bytes/ do |file_size_bytes|
  assert file_size_bytes = File.size(@audio_file)
end