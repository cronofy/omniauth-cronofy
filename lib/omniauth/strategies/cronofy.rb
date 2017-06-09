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
          'raw_info' => raw_info,
          'linking_profile' => access_token['linking_profile'],
        }
      end

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      def raw_info
        @raw_info ||= access_token.get("#{::OmniAuth::Strategies::Cronofy.api_url}/v1/account").parsed['account']
      end

      def request_phase
        link_token = session['omniauth.params']['link_token']
        if link_token && !link_token.empty?
          options[:authorize_params] ||= {}
          options[:authorize_params].merge!(:link_token => link_token)
        end
        super
      end
    end
  end
end
