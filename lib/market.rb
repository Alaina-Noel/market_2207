class Market
  attr_reader :name, :vendors, :date

  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today.strftime('%d/%m/%Y')
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
    item_count[item]
  end

  def overstocked_items
    list_items_sold_by_multiple_vendors.find_all do |item|
      sum_of_item(item) > 50
    end
  end

  def item_list
    all_items = Hash.new{ |h, k| h[k] = Hash.new(0)}
    @vendors.flat_map do |vendor|
      vendor.inventory.map do |item, quantity|
        all_items[item] = Hash.new(0)
      end
    end
    all_items
  end

  def total_inventory
    inventory_hash = item_list
      item_list.each do |item, details_hash|
      inventory_hash[item][:quantity] = sum_of_item(item)
      inventory_hash[item][:vendors] = vendors_that_sell(item)
    end
    inventory_hash
  end

  def sell(item, quantity)
    return false if sum_of_item(item) < quantity
      remaining_quantity = quantity
      @vendors.each do |vendor|
        if vendor.check_stock(item) != 0 && vendor.check_stock(item) > 0
          if quantity > vendor.check_stock(item)
            remaining_quantity = quantity - vendor.check_stock(item)
            vendor.inventory[item] -= vendor.check_stock(item)
          elsif remaining_quantity <= vendor.check_stock(item)
            vendor.inventory[item] -= remaining_quantity
          end
        end
      end
    true
  end

end
