require "spec_helper"

RSpec.describe TodoableApi::BaseModel do
  let(:mock_client) { double("mock_client") }
  let(:new_base_model) { TodoableApi::BaseModel.new }
  let(:data) do
    {
      id: 1,
      src: "foobar.com",
      name: "Foo"
    }
  end

  before(:each) do
    allow(TodoableApi::BaseModel).to receive(:client).and_return(mock_client)
  end

  it 'should return a client object' do
    expect(TodoableApi::BaseModel.client).to eq(mock_client)
  end

  it { should respond_to :id }
  it { should respond_to :id= }
  it { should respond_to :attributes }
  it { should respond_to :attributes= }
  it { should respond_to :name }
  it { should respond_to :name= }

  it 'should assign to the attributes variable' do
    new_base_model.assign_attributes(data)
    expect(new_base_model.attributes).to eq(data)
  end

  it 'should assign an id' do
    new_base_model.assign_attributes(data)
    expect(new_base_model.id).to eq(data[:id])
  end
end