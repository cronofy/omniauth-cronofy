module OmniAuth
  module Strategies
    class Cronofy < OmniAuth::Strategies::OAuth2
      option :name, "cronofy"

      def self.api_url
        @api_url ||= (ENV['CRONOFY_API_URL'] || data_centre_api_url || "https://api.cronofy.com")
      end

      def self.data_centre_api_url
        case ENV['CRONOFY_DATA_CENTRE']
        when 'de'
          "https://api-#{ENV['CRONOFY_DATA_CENTRE']}.cronofy.com"
        end
      end

      def self.api_url=(value)
        @api_url = value
      end

      def self.app_url
        @app_url ||= (ENV['CRONOFY_APP_URL'] || data_centre_app_url || "https://app.cronofy.com")
      end

      def self.data_centre_app_url
        case ENV['CRONOFY_DATA_CENTRE']
        when 'de'
          "https://app-#{ENV['CRONOFY_DATA_CENTRE']}.cronofy.com"
        end
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
    end
  end
end
