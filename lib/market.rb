class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.find_all { |vendor| vendor.check_stock(item) != 0 }
  end

  def sorted_item_list
    @vendors.flat_map do |vendor|
      vendor.inventory.map do |item, quantity|
        item.name
      end
    end.uniq.sort
  end

  def list_items_sold_by_multiple_vendors
    items = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        items << item if vendors_that_sell(item).count > 1
      end
    end
    items.uniq
  end

  def sum_of_item(item)
    item_count = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        item_count[item] += quantity
      end
    end
    item_count
  end

  def overstocked_items
    list_items_sold_by_multiple_vendors.find_all do |item|
      sum_of_item(item)[item] > 50
    end
  end

end
