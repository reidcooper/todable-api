require "spec_helper"

RSpec.describe TodoableApi::Sessionable do
  let(:test_class) { Struct.new(:id) { include TodoableApi::Sessionable } }
  let(:double_client) { test_class.new('abcdef') }
  let(:auth_token) { { token: "abc", expires_at: DateTime.now + 1 } }
  let(:expired_auth_token) { { token: "abc", expires_at: DateTime.now } }

  it 'should return an auth endpoint' do
    expect(double_client.auth_endpoint.to_s).to eq('http://todoable.teachable.tech/api/authenticate')
  end

  describe '#connected?' do
    it 'should return true if connected?' do
      double_client.instance_variable_set("@auth_token", auth_token)
      expect(double_client.connected?).to be true
    end

    it 'should return false if no auth token' do
      double_client.instance_variable_set("@auth_token", {})
      expect(double_client.connected?).to be false
    end

    it 'should return false if expired' do
      double_client.instance_variable_set("@auth_token", expired_auth_token)
      expect(double_client.connected?).to be false
    end
  end

  describe '#connect!' do
    before(:each) do
      TodoableApi.configure do |config|
        config.username = "foo"
        config.password = "bar"
      end
    end

    after(:each) do
      TodoableApi.instance_variable_set("@configuration", nil)
    end

    it 'should return auth token if it does not have one' do
      stub_request(:post, "http://todoable.teachable.tech/api/authenticate").with(basic_auth: ['foo', 'bar']).to_return(status: 200, body: auth_token.to_json, headers: {})
      expect(double_client.connect!).to eq auth_token[:token]
    end

    it 'should return auth token if its already connected' do
      stub_request(:post, "http://todoable.teachable.tech/api/authenticate").with(basic_auth: ['foo', 'bar']).to_return(status: 200, body: auth_token.to_json, headers: {})

      expect(double_client).to receive(:retrieve_auth_token).once.and_call_original

      double_client.connect!

      expect(double_client.connect!).to eq auth_token[:token]
    end

    it 'should return no token if failed response' do
      stub_request(:post, "http://todoable.teachable.tech/api/authenticate").with(basic_auth: ['foo', 'bar']).to_return(status: 200, body: '{}', headers: {})
      expect(double_client.connect!).to be nil
    end
  end
end