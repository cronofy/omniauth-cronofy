module OmniAuth
  module Strategies
    class CronofyServiceAccount < CronofyBase
      option :name, "cronofy_service_account"

      option :client_options, {
        :authorize_url => "/enterprise_connect/oauth/authorize",
      }

      def request_phase
        options[:authorize_params] = { delegated_scope: options[:delegated_scope]} if options[:delegated_scope]
        super
      end

      uid { raw_info['sub'] }

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
        @raw_info ||= access_token.get("#{client_options[:api_url]}/v1/userinfo").parsed
      end
    end
  end
end
