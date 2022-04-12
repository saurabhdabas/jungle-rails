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
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates :price, presence: true' do
      @category = Category.new(name: "Cars")
      @product = Product.new(
        name: "Ford Ram 150",
        price: nil,
        quantity: 7,
        category: @category
      )
      @product.save
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'validates :quantity, presence: true' do
      @category = Category.new(name: "Balls")
      @product = Product.new(
        name: "Pingpong Ball",
        price: 3,
        quantity: nil,
        category: @category
      )
      @product.save
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates :category, presence: true' do
      @category = Category.new(name: "Cars")
      @product = Product.new(
        name: "Toyota",
        price: 69000,
        quantity: 23,
        category: nil
      )
      @product.save
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end 

