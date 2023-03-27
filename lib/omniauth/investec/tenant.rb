# frozen_string_literal: true

module OmniAuth
  module Investec
    class Tenant
      def initialize(strategy)
        @strategy = strategy
      end

      def client_id
        raise NotImplementedError, 'Subclasses must implement a client_id method'
      end

      def client_secret
        raise NotImplementedError, 'Subclasses must implement a client_secret method'
      end

      def scope
        OmniAuth::Strategies::Investec::DEFAULT_SCOPE
      end
    end
  end
end
