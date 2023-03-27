# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Investec < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'accounts transactions'

      option :client_options,
        site: 'https://openapi.investec.com',
        authorize_url: 'https://openapi.investec.com/identity/v2/oauth2/authorize',
        token_url: 'https://openapi.investec.com/identity/v2/oauth2/token'

      option :skip_info, true # Investec's API does not expose any user info.
      option :provider_ignores_state, true # Investec's API does not send the state value back in the callback. [https://www.rfc-editor.org/rfc/rfc6749#page-72]
      option :scope, DEFAULT_SCOPE
      option :tenant_provider_class, nil

      def client
        return super unless options.tenant_provider_class

        provider = options.tenant_provider_class.new(self)
        options.client_id = provider.client_id
        options.client_secret = provider.client_secret
        options.scope = provider.scope

        super
      end

      def authorize_params
        super.tap do |params|
          params[:scope] = options.scope
        end
      end

      def request_phase
        uri = URI(client.auth_code.authorize_url({ redirect_uri: callback_url }.merge(authorize_params)))
        response = Net::HTTP.get_response(uri)

        # TODO: Handle 400, 401 and 500 errors.
        redirect response.to_hash['location']&.first
      end

      private

      def callback_url
        full_host + callback_path
      end
    end
  end
end
