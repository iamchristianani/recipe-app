require 'rails_helper'

RSpec.describe "Public Recipes Index Page", type: :feature do
  let!(:user) { FactoryBot.create(:user) }

  before do
    ActionMailer::Base.deliveries.clear
    user.confirmation_token = Devise.token_generator.generate(User, :confirmation_token)
    user.confirmed_at = Time.current
    user.save
    sign_in user
    @recipes = FactoryBot.create_list(:recipe, 3, user: user)
    visit public_recipes_path
  end

  scenario "displays a list of public recipes" do
    expect(page).to have_content "Public Recipes"
  end

  it "displays a list of public recipes" do
    @recipes.each do |recipe|
      expect(page).to have_link(recipe.name, href: recipe_path(recipe))
      expect(page).to have_content("By: #{recipe.user.name}")
      expect(page).to have_content("Total food items: #{recipe.total_food_items}")
      expect(page).to have_content("Total price: #{number_to_currency(recipe.total_price)}")
    end
  end

  it "links to individual recipe pages" do
    @recipes.each do |recipe|
      expect(page).to have_link(recipe.name, href: recipe_path(recipe))
    end
  end
end