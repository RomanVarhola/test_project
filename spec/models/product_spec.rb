require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'get products' do
    let(:user) do 
      User.create(first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name) 
    end
    let(:first_category) { Category.create(title: 'Dystopian') }
    let(:second_category) { Category.create(title: 'Fiction') }
    let(:third_category) { Category.create(title: 'Classic') }
    let(:first_product) do 
      Product.create(title: Faker::Movie.quote,
                    user: user,
                    rating: rand(0..5),
                    categories: [first_category, second_category])
    end
    let(:second_product) do 
      Product.create(title: Faker::Movie.quote,
                    user: user,
                    rating: rand(0..5),
                    categories: [third_category])
    end

    it 'should return fisrt_product' do
      first_product
      second_product
      items = [first_category, second_category].pluck(:title)
      expect(Product.with_categories(items)).to eq([first_product])
    end

    it 'should return second_products' do
      first_product
      second_product
      items = [third_category].pluck(:title)
      expect(Product.with_categories(items)).to eq([second_product])
    end

    it 'should return empty array' do
      first_product
      second_product
      items = [first_category, third_category].pluck(:title)
      expect(Product.with_categories(items)).to eq([])
    end
  end
end
