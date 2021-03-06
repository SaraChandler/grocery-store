require 'csv'
module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end
#creates several instances of Order class, cleans csv data
    def self.all
      orders = []
      CSV.read('./support/orders.csv').each do |row|
        #[1, "banana:2;sandwich:2"]
        #row.each do |single_order|
          id = row.delete_at(0).to_i
          #["banana:2;sandwich:2"]
          products_array = row.join(' ')
          products_array = products_array.split(';')
           #["banana:2", "sandwich:2"]
           products = products_array.map { |i| i.split ':' }.to_h
           orders << self.new(id, products)
         end
         return orders

    end

#can return an instance of Order based on ID
    def self.find(id)
      all_orders = Grocery::Order.all
      all_orders.each do |element|
          if element.id == id
            return Order.new(element.id, element.products)
          end
      end
      raise ArgumentError.new("Id does not exist.")
    end
#adds product values, adds tax, rounds, returns total
    def total
      @sum = @products.values.inject(0, :+)
      @total = @sum + (@sum * 0.075).round(2)
      return @total
    end
#adds a product to an Order instance
    def add_product(product_name, product_price)
      @product_name = product_name
      @product_price = product_price
      @products.each do |key, value|
        if @product_name == key
          #puts "You've already added that product."
          return false
        end
      end
      @products[@product_name] = @product_price
      return true
    end


  end
end

# puts first_order = Grocery::Order.find(1)
# puts first_order.id
# puts first_order.products
  # all_orders = Grocery::Order.all
  # puts first_order = Grocery::Order.find(1)
  # one_order = Grocery::Order.new(all_orders)
  # puts one_order.Grocery::Order.find(1)
  # puts one_order.print_id
