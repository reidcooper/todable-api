require "spec_helper"

RSpec.describe TodoableApi::DefaultClient do
  let(:default_client) { TodoableApi::DefaultClient.new }
  let(:path) { 'foo' }
  let(:params) { {} }
  let(:auth_token) { 'abc' }
  let(:headers) do
    {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "Authorization" => "Token token=\"#{auth_token}\""
    }
  end

  it 'should be able to make a get request' do
    allow(default_client).to receive(:connect!).and_return(auth_token)
    expect(default_client).to receive(:request).with(method: :get, path: path, params: params, headers: headers)

    default_client.get(path: path, params: params)
  end

  it 'should be able to make a put request' do
    allow(default_client).to receive(:connect!).and_return(auth_token)
    expect(default_client).to receive(:request).with(method: :put, path: path, params: params, headers: headers)

    default_client.put(path: path, params: params)
  end

  it 'should be able to make a post request' do
    allow(default_client).to receive(:connect!).and_return(auth_token)
    expect(default_client).to receive(:request).with(method: :post, path: path, params: params, headers: headers)

    default_client.post(path: path, params: params)
  end

  it 'should be able to make a patch request' do
    allow(default_client).to receive(:connect!).and_return(auth_token)
    expect(default_client).to receive(:request).with(method: :patch, path: path, params: params, headers: headers)

    default_client.patch(path: path, params: params)
  end

  it 'should be able to make a delete request' do
    allow(default_client).to receive(:connect!).and_return(auth_token)
    expect(default_client).to receive(:request).with(method: :delete, path: path, params: params, headers: headers)

    default_client.delete(path: path, params: params)
  end
end