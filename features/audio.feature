Feature: Audio
  In order to ensure audio info is retrieved correctly and audio files are modified properly
  As a user who does not want to deal with audio files
  I want to get the segment of audio I ask for in the right format with all other parameters accounted for

  Scenario: Get audio info
    Given I am using an audio file located at "./test/fixtures/TestAudio1.wv"
    When I request the audio file information
    Then I should get information about the file
    And The length of the file should be 2,560,180 bytes
