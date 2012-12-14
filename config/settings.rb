# these settings are shared between the harvester and Rails.
class SharedSettings

  @settings

  def self.settings
    @settings ||= {
        :original_audio_paths       => %w(original original2),
        :cached_spectrogram_paths   => %w(cachedimages cachedimages2),
        :cached_audio_paths         => %w(cachedaudio cachedaudio2),
        :analysis_script_paths      => %w(analysisscripts),
        :analysis_result_paths      => %w(analysisresults),
        :cached_audio_defaults      =>   [
                                          {:channel => 0, :sample_rate => 22050, :format => '.mp3'},
                                          {:channel => 0, :sample_rate => 22050, :format => '.webma'},
                                          {:channel => 0, :sample_rate => 22050, :format => '.ogg'}
                                         ],
        :cached_spectrogram_defaults =>  [
                                          {:channel => 0, :sample_rate => 22050, :window => 512, :colour => :g, :format => '.png'}
                                         ]
        }
  end
end