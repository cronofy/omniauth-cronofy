module OmniAuth
  module Strategies
    class CronofyServiceAccount < OmniAuth::Strategies::OAuth2
      option :name, "cronofy_service_account"

      option :client_options, {
        :site => ::OmniAuth::Strategies::Cronofy.app_url,
        :authorize_url => "#{::OmniAuth::Strategies::Cronofy.app_url}/service_accounts/oauth/authorize",
      }

      def request_phase
        options[:authorize_params] = { delegated_scope: options[:delegated_scope]} if options[:delegated_scope]
        super
      end

      uid{ raw_info['sub'] }

      info do
        {
          :domain => raw_info['cronofy.service_account.domain'],
        }
      end

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      extra do
        {
          'raw_info' => raw_info,
        }
      end

      def raw_info
        @raw_info ||= access_token.get("#{::OmniAuth::Strategies::Cronofy.api_url}/v1/userinfo").parsed
      end
    end
  end
end
