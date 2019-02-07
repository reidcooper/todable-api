require "spec_helper"

RSpec.describe TodoableApi::List do
  let(:lists_attributes) do
    {
      "lists" => [
        {
          "name" => "Urgent Things",
          "src" => "http://todoable.teachable.tech/api/lists/foo",
          "id" => "foo"
        },
        {
          "name" => "Shopping List",
          "src" => "http://todoable.teachable.tech/api/lists/bar",
          "id" => "bar"
        }
      ]
    }
  end
  let(:list_attributes) do
    {
      "name" => "Urgent Things",
      "src" => "http://todoable.teachable.tech/api/lists/foo",
      "id" => "foo"
    }
  end
  let(:new_name_list_attributes) do
    {
      "name" => "New Name",
      "src" => "http://todoable.teachable.tech/api/lists/foo",
      "id" => "foo"
    }
  end
  let(:list_attributes_with_items) do
    {
      "name" => "New Name",
      "id" => "foo",
      "items" => [
        {
          "id" => "foobar1",
          "name" => "foo",
          "finished_at" => Time.now,
          "list_id" => "bar",
          "src" => "http://todoable.teachable.tech/api/lists/bar/items/foobar1"
        }
      ]
    }
  end

  let(:mocked_client) { double("client") }
  let(:list) { TodoableApi::List.new(list_attributes) }

  before(:each) do
    allow(TodoableApi::BaseModel).to receive(:client).and_return(mocked_client)
  end

  it 'should grab all lists' do
    allow(mocked_client).to receive(:get).with(path: "lists").and_return(lists_attributes)
    expect(TodoableApi::List.all).to all( be_an TodoableApi::List )
  end

  it 'should be able to create a new list' do
    allow(mocked_client).to receive(:post).with(path: "lists", params: { list: { name: 'Urgent Things' } }).and_return(list_attributes)
    list = TodoableApi::List.create('Urgent Things')
    expect(list.name).to eq('Urgent Things')
  end

  it 'should be able to find a list' do
    allow(mocked_client).to receive(:get).with(path: "lists/foo").and_return(list_attributes)
    list = TodoableApi::List.find('foo')
    expect(list.id).to eq('foo')
  end

  it 'should be able to delete a list' do
    allow(mocked_client).to receive(:delete).with(path: "lists/foo").and_return("")
    expect(TodoableApi::List.delete('foo')).to be_truthy
  end

  it 'should be able to update a list' do
    allow(mocked_client).to receive(:patch).with(path: "lists/foo", params: { list: { name: 'New Name' } }).and_return('')
    expect(TodoableApi::List.update('foo', 'New Name')).to be_truthy
  end

  it 'should be able to save a list' do
    allow(mocked_client).to receive(:patch).with(path: "lists/foo", params: { list: { name: 'New Name' } }).and_return('')
    allow(mocked_client).to receive(:get).with(path: "lists/foo").and_return(new_name_list_attributes)
    list.name = "New Name"
    expect(list.save).to eq(list)
  end

  it 'should be able to reload a list' do
    allow(mocked_client).to receive(:get).with(path: "lists/foo").and_return(list_attributes)
    expect(list.reload).to be list
  end

  it 'should be able to set the name of the list' do
    list.name = "new name"
    expect(list.name).to eq("new name")
    expect(list.attributes["name"]).to eq("new name")
  end

  it 'should be able to grab the lists items' do
    list = TodoableApi::List.new(list_attributes_with_items)
    expect(list.items).to all( be_an TodoableApi::Item )
  end
end