require 'rails_helper'

RSpec.feature 'Foods index', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  before do
    ActionMailer::Base.deliveries.clear
    user.confirmation_token = Devise.token_generator.generate(User, :confirmation_token)
    user.confirmed_at = Time.current
    user.save
    sign_in user
    FactoryBot.create_list(:food, 3, user:)
    visit foods_path
  end
  scenario 'allows user to add a food' do
    click_on 'Add Food'
    fill_in 'Name', with: 'Jamal Goda'
    fill_in 'Measurement unit', with: 'Pound'
    fill_in 'Price', with: 10.00
    fill_in 'Quantity', with: 10
    click_on 'Save Food'
    expect(page).to have_content 'Jamal Goda'
    expect(page).to have_selector 'table tbody tr', count: 4
  end
end
