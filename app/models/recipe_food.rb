class RecipeFood < ApplicationRecord
  validates :quantity, presence: true
  
  belongs_to :food
  belongs_to :recipe
end
