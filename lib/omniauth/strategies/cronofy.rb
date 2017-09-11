module OmniAuth
  module Strategies
    class Cronofy < CronofyBase
      option :name, "cronofy"

      uid { raw_info['account_id'] }

      info do
        {
          :email => raw_info['email'],
          :name => raw_info['name']
        }
      end

      extra do
        {
          'raw_info' => raw_info,
          'linking_profile' => access_token['linking_profile'],
        }
      end

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      def raw_info
        @raw_info ||= access_token.get("#{client_options[:api_url]}/v1/account").parsed['account']
      end
    end
  end
end
