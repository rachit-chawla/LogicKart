class Product < ActiveRecord::Base
	self.primary_key = 'product_id'
	belongs_to :category, foreign_key: :category_id
end
