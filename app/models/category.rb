class Category < ApplicationRecord
  include ActiveHash::Associations
  has_many :items

end
