require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'saves a product with a name, price, quantity and category' do
      @category = Category.new(name: "Cars")
      @product = Product.new(
        name: 'Tesla',
        price: 60000,
        quantity: 8,
        category: @category
      )
      @product.save
      expect(@product).to be_valid
    end

    it 'validates :name, presence: true' do
      @category = Category.new(name: "Cars")
      @product = Product.new(
        name: nil,
        price: 5,
        quantity: 20,
        category: @category
      )
      @product.save
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Name cannot be empty")
    end

  end
end 

