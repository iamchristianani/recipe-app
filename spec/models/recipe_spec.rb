require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:ellon) { User.create(name: 'Ellon', email: 'abc.gmail.com') }
  let!(:flour) { Food.create(name: "Flour", price: 0.50, measurement_unit: "gram", quantity: 1000, user: ellon) }
  let!(:sugar) { Food.create(name: "Sugar", price: 0.75, measurement_unit: "gram", quantity: 1000, user: ellon) }
  let!(:apple) { Food.create(name: "Apple", price: 5, measurement_unit: "gram", quantity: 1000, user: ellon) }

  let!(:apple_cake) { Recipe.create(name: "Apple cake", description: 'This is apple cake recipe', preparation_time: '1 hour', cooking_time: '1.5 hours', public: true, user: ellon) }

  let!(:recipe_food1) { RecipeFood.create(recipe: apple_cake, food: flour, quantity: 50) }
  let!(:recipe_food2) { RecipeFood.create(recipe: apple_cake, food: sugar, quantity: 10) }  
  let!(:recipe_food3) { RecipeFood.create(recipe: apple_cake, food: apple, quantity: 10) }

  describe 'methods' do
    describe '#total_food_items' do
      it 'returns the total number of unique food items in the recipe' do
        expect(apple_cake.total_food_items).to eq(3)
      end
    end

    describe '#total_price' do
      it 'calculates the total price of the recipe' do
        expect(apple_cake.total_price).to eq(82.5)
      end
    end
  end
end
