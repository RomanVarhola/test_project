class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :user

  scope :with_categories, ->(category_titles) {
    return if category_titles.none?

    category_ids = Category.where(title: category_titles).ids

    return if category_ids.size < category_titles.size

    joins('INNER JOIN categories_products ON categories_products.product_id = products.id').
    where("categories_products.category_id IN (#{category_ids.join(', ')})").
    group('products.id').
    having("COUNT('products.id') = #{category_ids.size}")
  }
end
