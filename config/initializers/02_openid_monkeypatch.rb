# from https://gist.github.com/tispratik/2316649
# https://github.com/intridea/omniauth/issues/428#issuecomment-4990700
Rails.application.config.middleware.use OmniAuth::Builder do
  require 'rack/openid'
  require 'openid/consumer/idres'
  require 'omniauth/strategies/open_id'

# This patch is required:
# For: google authentication.
# When: Running rails on a port other than 80 where a proxy server proxies to rails.
# Cause: 1. Rack is not able to figure out that it should not set the realm url port to the rails custom port in case the full_host is mentioned using
#           OmniAuth.config.full_host
#        2. OpenID tries to validate the incoming callback url with the custom port that rails is running on and throws the error "return_to #{meth.to_s} does not match".

  env = Rails.env

  if env != "development"
    # this is set in the private configuration
    #OmniAuth.config.full_host = "http://example.com"


    # Fixing the realm url
    module Rack
      class OpenID
        private
        def realm_url(req)
          url = req.scheme + "://"
          url << req.host
          url
        end
      end
    end

    # Removing :port from the list of variables to verify
    module OpenID
      class Consumer
        class IdResHandler
          def verify_return_to_base(msg_return_to)
            begin
              app_parsed = URI.parse(URINorm::urinorm(@current_url))
            rescue URI::InvalidURIError
              raise ProtocolError, "current_url is not a valid URI: #{@current_url}"
            end

            [:scheme, :host, :path].each do |meth|
              if msg_return_to.send(meth) != app_parsed.send(meth)
                raise ProtocolError, "return_to #{meth.to_s} does not match"
              end
            end
          end
        end
      end
    end

    # http://www.arailsdemo.com/posts/18
    # Using Logger To Get More Information
    require 'active_record'
    class OmniAuth::Strategies::OpenID
      def callback_phase
        env['REQUEST_METHOD'] = 'GET'
        openid = Rack::OpenID.new(lambda { |env| [200, {}, []] }, @store)
        openid.call(env)
        @openid_response = env.delete('rack.openid.response')

        if @openid_response && @openid_response.status == :success
          super
        else
          ActiveRecord::Base.logger.debug "###########" + @openid_response.to_yaml + "#########"
          fail!(:invalid_credentials)
        end
      end
    end
  end
end