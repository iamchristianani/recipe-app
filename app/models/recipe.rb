class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  def total_food_items
    
  end

  def total_price

  end
end
