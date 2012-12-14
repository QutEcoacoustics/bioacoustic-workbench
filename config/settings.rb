# these settings are shared between the harvester, analysis runner and Rails.
class SharedSettings

  @settings

  def self.settings
    @settings ||= {
        :original_audio_paths       => %w(original),
        :cached_spectrogram_paths   => %w(cachedimages),
        :cached_audio_paths         => %w(cachedaudio),
        :analysis_script_paths      => %w(analysisscripts),
        :analysis_result_paths      => %w(analysisresults),
        :analysis_run_path          => 'analysisruns',
        :harvester_base_dir         => 'harvestwaiting',
        :cached_audio_defaults      =>   [
                                          {:channel => 0, :sample_rate => 22050, :format => '.webma'},
                                          {:channel => 0, :sample_rate => 22050, :format => '.mp3'},
                                          {:channel => 0, :sample_rate => 22050, :format => '.ogg'}
                                         ],
        :cached_spectrogram_defaults =>  [
                                          {:channel => 0, :sample_rate => 22050, :window => 512, :colour => 'a', :format => '.png'}
                                         ]
        }
  end
end