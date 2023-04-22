require 'rails_helper'

RSpec.describe PublicRecipesController, type: :controller do
  describe 'GET #index' do
    let(:user) { FactoryBot.create(:user) }

    before do
      ActionMailer::Base.deliveries.clear
      user.confirmation_token = Devise.token_generator.generate(User, :confirmation_token)
      user.confirmed_at = Time.current
      user.save
      sign_in user

      get :index
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'assigns public recipes to @recipes' do
      public_recipe1 = FactoryBot.create(:recipe, public: true, user:)
      public_recipe2 = FactoryBot.create(:recipe, public: true, user:)
      expect(assigns(:recipes)).to match_array([public_recipe2, public_recipe1])
    end

    it 'orders recipes by created_at in descending order' do
      public_recipe1 = FactoryBot.create(:recipe, public: true, created_at: 1.day.ago, user:)
      public_recipe2 = FactoryBot.create(:recipe, public: true, created_at: 2.days.ago, user:)
      public_recipe3 = FactoryBot.create(:recipe, public: true, created_at: 3.days.ago, user:)
      expect(assigns(:recipes)).to eq([public_recipe1, public_recipe2, public_recipe3])
    end
  end
end
