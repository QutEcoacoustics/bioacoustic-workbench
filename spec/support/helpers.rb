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