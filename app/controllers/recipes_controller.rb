class RecipesController < ApplicationController
  def index
    @recipe = current_user.recipes
  end

  def show
    # @user = User.find(params[:user_id])
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    puts params.inspect
    if @recipe.save
      flash[:success] = 'Recipe successfully created'
      redirect_to recipes_path
    else
      flash[:danger] = "Couldn't create recipe"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:success] = 'Recipe deleted!'
    redirect_to recipes_path
  end

  def shopping_list
    @missing_foods = current_user.foods.where.not(id: RecipeFood.includes(:recipe)
                             .where(recipes: { user_id: current_user.id }).pluck(:food_id))
    @shopping_list_items = {}
    @total_items = 0
    @total_price = 0.0
    return unless params[:recipe_id].present?

    @recipe = current_user.recipes.find(params[:recipe_id])
    @missing_foods.each do |food|
      quantity = food.quantity
      price = food.price * quantity
      if @shopping_list_items[food.id].present?
        @shopping_list_items[food.id][:quantity] += quantity
        @shopping_list_items[food.id][:price] += price
      else
        @shopping_list_items[food.id] = { food:, quantity:, price: }
      end
      @total_price += price
    end
    @total_items += @missing_foods.select(:id).distinct.count
    @shopping_list_items = @shopping_list_items.values.sort_by { |item| item[:food].name }
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
