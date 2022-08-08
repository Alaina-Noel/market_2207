require './lib/item'

RSpec.describe do
  it 'exists' do
    item1 = Item.new({name: 'Peach', price: "$0.75"})

    expect(item1).to be_instance_of(Item)
  end

  it 'has atttributes' do
    item2 = Item.new({name: 'Tomato', price: '$0.50'})

    expect(item1.name).to eq('Tomato')
    expect(item1.price).to eq(0.5)
  end
end
