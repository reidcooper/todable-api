require "spec_helper"

RSpec.describe TodoableApi::Item do
  let(:item_attributes) do
    {
      "id" => "foobar1",
      "name" => "foo",
      "finished_at" => nil,
      "list_id" => "bar",
      "src" => "http://todoable.teachable.tech/api/lists/bar/items/foobar1"
    }
  end
  let(:list_attributes) do
    {
      "name" => "foolist",
      "items" => [
        {
          "id" => "foobar1",
          "name" => "foo",
          "finished_at" => nil,
          "list_id" => "bar",
          "src" => "http://todoable.teachable.tech/api/lists/bar/items/foobar1"
        },
        {
          "id" => "foobar2",
          "name" => "foo2",
          "finished_at" => nil,
          "list_id" => "bar2",
          "src" => "http://todoable.teachable.tech/api/lists/bar/items/foobar2"
        }
      ]
    }
  end
  let(:list_with_finished) do
    {
      "name" => "foolist",
      "items" => [
        {
          "id" => "foobar1",
          "name" => "foo",
          "finished_at" => Time.now,
          "list_id" => "bar",
          "src" => "http://todoable.teachable.tech/api/lists/bar/items/foobar1"
        },
        {
          "id" => "foobar2",
          "name" => "foo2",
          "finished_at" => nil,
          "list_id" => "bar2",
          "src" => "http://todoable.teachable.tech/api/lists/bar/items/foobar2"
        }
      ]
    }
  end

  let(:item) { TodoableApi::Item.new(item_attributes) }
  let(:mocked_client) { double("client") }

  before(:each) do
    allow(TodoableApi::BaseModel).to receive(:client).and_return(mocked_client)
  end

  it { should respond_to :finished_at }
  it { should respond_to :finished_at= }
  it { should respond_to :list_id }
  it { should respond_to :list_id= }

  it 'creates an object' do
    expect(item.id).to eq("foobar1")
  end

  it 'returns true if finished' do
    item.finished_at = Time.now
    expect(item.finished?).to be true
  end

  it 'returns false if not finished' do
    item.finished_at = nil
    expect(item.finished?).to be false
  end

  it 'makes a request to finish the item' do
    allow(mocked_client).to receive(:get).with(path: "lists/#{item.list_id}").and_return(list_with_finished)
    expect(mocked_client).to receive(:put).with(path: "lists/#{item.list_id}/items/#{item.id}/finish").and_return("foo finished")
    item.finish
  end

  it 'returns its list' do
    allow(mocked_client).to receive(:get).with(path: "lists/#{item.list_id}").and_return(list_attributes)
    expect(item.list).to be_kind_of(TodoableApi::List)
  end

  it 'can create a new item' do
    allow(mocked_client).to receive(:post).with(path: "lists/bar/items", params: { item: { name: 'foo' }}).and_return(item_attributes)
    item = TodoableApi::Item.create('bar', 'foo')
    expect(item.name).to eq('foo')
  end

  it 'can delete an item' do
    allow(mocked_client).to receive(:delete).with(path: "lists/#{item.list_id}/items/#{item.id}").and_return("")
    expect(TodoableApi::Item.delete(item.list_id, item.id)).to be_truthy
  end

  it 'can mark an item as finished' do
    allow(mocked_client).to receive(:put).with(path: "lists/#{item.list_id}/items/#{item.id}/finish").and_return("")
    expect(TodoableApi::Item.mark_as_finished(item.list_id, item.id)).to be_truthy
  end
end