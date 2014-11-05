class Category < ActiveRecord::Base
	self.primary_key = 'category_id'
	has_many :products, dependent: :destroy
end