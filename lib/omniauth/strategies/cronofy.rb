module OmniAuth
  module Strategies
    class Cronofy < CronofyBase
      WHITELISTED_AUTHORIZE_PARAMS = %w{
        avoid_linking
        link_token
        provider_name
      }

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

      def request_phase
        session_params = session['omniauth.params']
        params = {}

        WHITELISTED_AUTHORIZE_PARAMS.each do |param|
          next unless session_params[param]
          params[param] = session_params[param]
        end

        if options[:authorize_params]
          options[:authorize_params].merge!(params)
        else
          options[:authorize_params] = params
        end

        super
      end
    end
  end
end
