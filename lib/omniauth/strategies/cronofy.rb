require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Cronofy < OmniAuth::Strategies::OAuth2
      option :name, "cronofy"

      option :client_options, {
        :site => "https://app.cronofy.com"
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
        @raw_info ||= access_token.get('https://api.cronofy.com/v1/account').parsed['account']
      end
    end
  end
end