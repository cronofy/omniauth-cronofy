require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Cronofy < OmniAuth::Strategies::OAuth2
      option :name, "cronofy"

      APP_HOST = "https://app.cronofy.com"
      API_HOST = "https://api.cronofy.com"

      option :client_options, {
        :site => APP_HOST
      }

      uid{ raw_info['account_id'] }

      info do
        {
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get("#{API_HOST}/v1/account").parsed['account']
      end
    end
  end
end