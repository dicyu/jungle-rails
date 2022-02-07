require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it 'validates' do
      @product = Product.new
      @category = Category.new
      @category.name = "Video Games"
      @product.name = "Lost Ark"
      @product.price_cents = 2799
      @product.quantity = 5
      @product.category = @category
      expect(@product.valid?).to be true
    end

    it 'validates name is present' do
      @product = Product.new
      @product.name = nil
      expect(@product.valid?).to be false
      expect(@product.errors.messages[:name]).to include "can't be blank"
    end

    it 'validates price is present' do
      @product = Product.new
      @product.price_cents = nil
      expect(@product.valid?).to be false
      expect(@product.errors.messages[:price_cents]).to include "is not a number"
    end

    it 'validates quantity is present' do
      @product = Product.new
      @product.quantity = nil
      expect(@product.valid?).to be false
      expect(@product.errors.messages[:quantity]).to include "can't be blank"
    end

    it 'validates category is present' do
      @product = Product.new
      @product.category = nil
      expect(@product.valid?).to be false
      expect(@product.errors.messages[:category]).to include "can't be blank"
    end
  end
end
