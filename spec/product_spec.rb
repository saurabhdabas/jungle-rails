require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'saves a product with a name, price, quantity and category' do
      @category = Category.new(name: "Furniture")
      @product = Product.new(
        name: 'Teak Wood Chair',
        price: 60,
        quantity: 8,
        category: @category
      )
      @product.save
      expect(@product).to be_valid
    end
  end
end 

