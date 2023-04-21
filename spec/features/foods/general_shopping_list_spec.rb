require 'rails_helper'

RSpec.feature 'Shopping List', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    ActionMailer::Base.deliveries.clear
    user.confirmation_token = Devise.token_generator.generate(User, :confirmation_token)
    user.confirmed_at = Time.current
    user.save
    sign_in user
    FactoryBot.create_list(:food, 3, user:)
    visit general_shopping_list_index_path
  end

  scenario 'displays a list of foods' do
    expect(page).to have_content 'Shopping List'
    expect(page).to have_content 'Amount of food items to buy: 3'
    expect(page).to have_content 'Total value of food needed: $150.00'
    expect(page).to have_selector 'table tbody tr', count: 3
  end
end
