require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'all fields are fulfilled' do
      @category = Category.new()
      @product = Product.new(:name=> "Testing" , :price => 8, :quantity => 2, :category => @category)
      @product.valid?
      expect(@product.errors.full_messages.empty?).to be true
    end

    it 'name is nil' do  
      @product = Product.new(:name=> nil)
      @product.valid? 
      expect(@product.errors.full_messages).to include "Name can't be blank" 
    end
    
    it 'price is nil' do
     @product = Product.new(:price => nil)
     @product.valid?
     expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it 'quantity is nil' do
    @product = Product.new(:quantity => nil)
    @product.valid?
    expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it 'category is nil' do
      @product = Product.new(:category => nil)
      @product.valid?
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end
end
