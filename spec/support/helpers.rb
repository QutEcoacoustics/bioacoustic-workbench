# https://gist.github.com/3317023
module JsonHelpers

  def json(params)
    params = {format: 'json'}.merge(params)
    [:get, :put, :post, :delete].find do |method|
      path = params.delete(method) and send(method, path, params)
    end
    symbolize_keys(JSON.parse(response.body))
  end

  private

  def symbolize_keys(o)
    case o
      when Hash then Hash[o.map { |k, v| [k.to_sym, symbolize_keys(v)] }]
      when Array then o.map { |e| symbolize_keys(e) }
      else o
    end
  end

end

RSpec.configure { |config| config.include JsonHelpers, :type => :request }

module AudioHelpers
  # Add more helper methods to be used by all tests here...
  def self.get_source_audio_file_path(file_name)
    input_path = './test/fixtures/audio'
    File.join input_path, file_name
  end

  def self.get_temp_file_path(file_name)
    output_path = './tmp/testassests'
    FileUtils.makedirs(output_path)
    File.join output_path, file_name
  end

  def self.delete_if_exists(file_path)

    file_name = file_path.chomp(File.extname(file_path))
    possible_paths = [file_path, file_name+'.webm', file_name+'.ogg']

    possible_paths.each{|file|
      if File.exists? file
        File.delete file
      end
    }
  end
end

RSpec.configure { |config| config.include AudioHelpers, :type => :model }
