require 'rails_helper'
RSpec.describe 'Recipes show Page', type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  before do
    ActionMailer::Base.deliveries.clear
    user.confirmation_token = Devise.token_generator.generate(User, :confirmation_token)
    user.confirmed_at = Time.current
    user.save
    sign_in user
    @recipes = FactoryBot.create(:recipe, user:)
    @food = Food.create(name: 'Banana', measurement_unit: 'grams', price: 12, quantity: 10, user:)
    visit recipe_path(@recipes)
  end
  scenario 'load new recipe page' do
    expect(page).to have_content @recipes.name
    expect(page).to have_content "Preparation Time: #{@recipes.preparation_time}"
    expect(page).to have_content "Cooking Time: #{@recipes.cooking_time}"
    expect(page).to have_content 'Steps:'
    expect(page).to have_content @recipes.description
    expect(page).to have_content 'Current Status:'
    expect(page).to have_link 'Generate shopping list'
    expect(page).to have_link 'Add Ingredient'
  end
  scenario 'user can add a new recipe' do
    click_on 'Generate shopping list'
    expect(page).to have_current_path(general_shopping_list_index_path)
  end

  scenario 'user can add a new recipe' do
    click_on 'Add Ingredient'
    expect(page).to have_current_path(new_recipe_recipe_food_path(@recipes.id))
  end

  scenario 'allows user to add a food' do
    click_on 'Add Ingredient'
    select 'Banana', from: 'recipe_food[food_id]'
    fill_in 'Quantity', with: 10
    click_on 'Add Ingredient'
  end
end
