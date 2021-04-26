module OmniAuth
  module Strategies
    class CronofyBase < OmniAuth::Strategies::OAuth2
      option :data_center, nil

      def api_url
        ENV['CRONOFY_API_URL'] || data_center_url(:api, data_center_env) || "https://api.cronofy.com"
      end

      def app_url
        ENV['CRONOFY_APP_URL'] || data_center_url(:app, data_center_env) || "https://app.cronofy.com"
      end

      def data_center_env
        ENV['CRONOFY_DATA_CENTER'] || ENV['CRONOFY_DATA_CENTRE']
      end

      def data_center_url(type, value)
        case value.to_s
        when 'au', 'de', 'ca', 'sg', 'uk'
          "https://#{type}-#{value}.cronofy.com"
        end
      end

      def client_options
        client_options = deep_symbolize(options.client_options)

        unless client_options[:site]
          if options.data_center
            client_options[:site] = data_center_url(:app, options.data_center)
          end

          unless client_options[:site]
            client_options[:site] = app_url
          end
        end

        unless client_options[:api_url]
          if options.data_center
            client_options[:api_url] = data_center_url(:api, options.data_center)
          end

          unless client_options[:api_url]
            client_options[:api_url] = api_url
          end
        end

        log :debug, "site: #{client_options[:site]}, api_url: #{client_options[:api_url]}"

        client_options
      end

      def client
        ::OAuth2::Client.new(options.client_id, options.client_secret, client_options)
      end
    end
  end
end
