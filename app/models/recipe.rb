class Recipe < ApplicationRecord
  belongs_to :user
  has_many :foods
end
