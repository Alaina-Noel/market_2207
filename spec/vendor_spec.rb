require './lib/item'
require './lib/vendor'

RSpec.describe do
  it 'exists' do
    vendor = Vendor.new("Rocky Mountain Fresh")
    expect(vendor).to be_instance_of(Vendor)
  end

  it 'has atttributes' do
    vendor = Vendor.new("Rocky Mountain Fresh")

    expect(vendor.name).to eq("Rocky Mountain Fresh")
    expect(vendor.inventory).to eq({})
  end

  it 'can check its stock which is empty by default' do
    vendor = Vendor.new("Rocky Mountain Fresh")

    expect(vendor.check_stock(item1)).to eq(0)
  end

  it 'can add to its stock and inventory' do
    vendor = Vendor.new("Rocky Mountain Fresh")

    expect(vendor.check_stock(item1)).to eq(0)
    vendor.stock(item1, 30)
    expect(vendor.inventory).to eq({item1 => 30})
    expect(vendor.check_stock(item1)).to eq(30)
    vendor.stock(item1, 25)
    expect(vendor.check_stock(item1)).to eq(55)
    vendor.stock(item2, 12)
    expect(vendor.inventory).to eq({item1 => 55, item2 => 12})
  end
  
end
