require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Cronofy < OmniAuth::Strategies::OAuth2
      option :name, "cronofy"

      def self.api_url
        @api_url ||= (ENV['CRONOFY_API_URL'] || "https://api.cronofy.com")
      end

      def self.api_url=(value)
        @api_url = value
      end

      def self.app_url
        @app_url ||= (ENV['CRONOFY_APP_URL'] || "https://app.cronofy.com")
      end

      def self.app_url=(value)
        @app_url = value
      end

      option :client_options, {
        :site => ::OmniAuth::Strategies::Cronofy.app_url
      }

      uid{ raw_info['account_id'] }

      info do
        {
          :email => raw_info['email'],
          :name => raw_info['name']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get("#{::OmniAuth::Strategies::Cronofy.api_url}/v1/account").parsed['account']
      end
    end
  end
end