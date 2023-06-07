class Condition < ApplicationRecord
  include ActiveHash::Associations
  has_many :items

end
