require "spec_helper"

RSpec.describe TodoableApi::Configuration do
  let(:default_config) { TodoableApi.configuration }

  it 'should return a new configuration' do
    expect(TodoableApi.configuration).to be_kind_of(TodoableApi::Configuration)
  end

  it 'should respond to #configure' do
    expect(TodoableApi).to respond_to(:configure)
  end

  it 'should initialize with defaults' do
    expect(default_config.endpoint).to eq("http://todoable.teachable.tech")
    expect(default_config.client_class).to be TodoableApi::DefaultClient
  end

  it 'should initialize with custom configs' do
    client_double = double("client")

    TodoableApi.configure do |config|
      config.username = "foo"
      config.password = "bar"
      config.endpoint = "example.com"
      config.client_class = client_double
    end

    expect(TodoableApi.configuration.username).to eq("foo")
    expect(TodoableApi.configuration.password).to eq("bar")
    expect(TodoableApi.configuration.endpoint).to eq("example.com")
    expect(TodoableApi.configuration.client_class).to eq(client_double)
  end
end