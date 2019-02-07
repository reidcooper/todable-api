require "spec_helper"

RSpec.describe TodoableApi::HTTPRequestable do
  let(:test_class) { Struct.new(:id) { include TodoableApi::HTTPRequestable } }
  let(:double_client) { test_class.new('abcdef') }

  it 'should be able to make a get request' do
    stub_request(:get, "http://todoable.teachable.tech/api/foo")

    response = double_client.request(method: :get, path: 'foo')

    expect(response).to eq("")
  end

  it 'should be able to make a put request' do
    stub_request(:put, "http://todoable.teachable.tech/api/foo").with(body: "{\"foo\":true}")

    response = double_client.request(method: :put, path: 'foo', params: { foo: true })

    expect(response).to eq("")
  end

  it 'should be able to make a post request' do
    stub_request(:post, "http://todoable.teachable.tech/api/foo").with(body: "{\"foo\":true}")

    response = double_client.request(method: :post, path: 'foo', params: { foo: true })

    expect(response).to eq("")
  end

  it 'should be able to make a patch request' do
    stub_request(:patch, "http://todoable.teachable.tech/api/foo").with(body: "{\"foo\":true}")

    response = double_client.request(method: :patch, path: 'foo', params: { foo: true })

    expect(response).to eq("")
  end

  it 'should be able to make a delete request' do
    stub_request(:delete, "http://todoable.teachable.tech/api/foo")

    response = double_client.request(method: :delete, path: 'foo')

    expect(response).to eq("")
  end

  it 'should return a URI with a custom path' do
    expect(double_client.api_endpoint('foo').to_s).to eq('http://todoable.teachable.tech/api/foo')
  end

  it 'should return true for 204 response' do
    response = double("response")
    allow(response).to receive(:code).and_return("204")

    expect(double_client.handle_api_response(response)).to eq(true)
  end

  it 'should return response body for 200..300 response' do
    random_code = ([*200..300] - [204]).sample # Any code but 204
    response = double("response")
    allow(response).to receive(:code).and_return("#{random_code}")
    allow(response).to receive(:body).and_return("hello")

    expect(double_client.handle_api_response(response)).to eq("hello")
  end

  it 'should raise Unauthorized error for 401 response' do
    response = double("response")
    allow(response).to receive(:code).and_return("401")

    expect { double_client.handle_api_response(response) }.to raise_error TodoableApi::Unauthorized
  end

  it 'should raise NotFound error for 404 response' do
    response = double("response")
    allow(response).to receive(:code).and_return("404")

    expect { double_client.handle_api_response(response) }.to raise_error TodoableApi::NotFound
  end

  it 'should raise UnprocessableEntity error for 422 response' do
    errors = {
      "errors" => {
        "name" => ["missing"],
        "email" => ["invalid_format"],
      }
    }
    response = double("response")
    allow(response).to receive(:code).and_return("422")
    allow(response).to receive(:body).and_return(errors.to_json)

    expect { double_client.handle_api_response(response) }.to raise_error TodoableApi::UnprocessableEntity
  end

  it 'should raise InternalServerError error for 500 response' do
    response = double("response")
    allow(response).to receive(:code).and_return("500")

    expect { double_client.handle_api_response(response) }.to raise_error TodoableApi::InternalServerError
  end
end