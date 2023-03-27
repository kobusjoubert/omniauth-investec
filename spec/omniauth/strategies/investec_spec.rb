# frozen_string_literal: true

RSpec.describe OmniAuth::Strategies::Investec do
  let(:app)     { -> { [200, {}, ['']] } }
  let(:request) { double('request', params: {}, cookies: {}, env: {}) }

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  subject do
    OmniAuth::Strategies::Investec.new(app, 'client_id', 'client_secret', @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) do
        request
      end
    end
  end

  describe '#client' do
    it 'returns the default site' do
      expect(subject.client.site).to eq('https://openapi.investec.com')
    end

    it 'allows overriding the site' do
      @options = { client_options: { site: 'https://custom.site.com' } }
      expect(subject.client.site).to eq('https://custom.site.com')
    end

    it 'returns the default authorize_url' do
      expect(subject.client.authorize_url).to eq('https://openapi.investec.com/identity/v2/oauth2/authorize')
    end

    it 'allows overriding the authorize_url' do
      @options = { client_options: { authorize_url: 'https://custom.site.com/authorize' } }
      expect(subject.client.authorize_url).to eq('https://custom.site.com/authorize')
    end

    it 'returns the default token_url' do
      expect(subject.client.token_url).to eq('https://openapi.investec.com/identity/v2/oauth2/token')
    end

    it 'allows overriding the token_url' do
      @options = { client_options: { token_url: 'https://custom.site.com/token' } }
      expect(subject.client.token_url).to eq('https://custom.site.com/token')
    end

    it 'sets the client id' do
      expect(subject.client.id).to eq('client_id')
    end

    it 'sets the client secret' do
      expect(subject.client.secret).to eq('client_secret')
    end
  end

  describe '#options' do
    it 'returns the default scope' do
      expect(subject.options.scope).to eq('accounts transactions')
    end

    it 'allows overriding the scope' do
      @options = { scope: 'balances accounts transactions transfers cards' }
      expect(subject.options.scope).to eq('balances accounts transactions transfers cards')
    end
  end

  describe '#tenant_provider_class' do
    let(:tenant_provider_class) do
      Class.new do
        def initialize(strategy); end

        def client_id
          'tenant_id'
        end

        def client_secret
          'tenant_secret'
        end

        def scope
          'accounts transactions'
        end
      end
    end

    subject do
      OmniAuth::Strategies::Investec.new(app, tenant_provider_class: tenant_provider_class).tap do |strategy|
        allow(strategy).to receive(:request) do
          request
        end
      end
    end

    it 'sets the tenant client id' do
      expect(subject.client.id).to eq('tenant_id')
    end

    it 'sets the tenant client secret' do
      expect(subject.client.secret).to eq('tenant_secret')
    end
  end
end
