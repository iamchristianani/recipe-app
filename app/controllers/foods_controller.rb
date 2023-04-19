class FoodsController < ApplicationController
  def index
    @foods = current_user.foods.all
  end

  def show
    @food = current_user.foods.find(params[:id])
  end

  def new
    @food = current_user.foods.new
  end

  def create
    @food = current_user.foods.new(food_params)
    if @food.save
      redirect_to foods_path, notice: 'Food was successfully saved.'
    else
      render :new
    end
  end

  def destroy
    @food = current_user.foods.find(params[:id])

    # authorize! :destroy, @food

    if @food.destroy
      flash[:success] = 'Food deleted successfully.'
    else
      flash[:error] = 'Failed to delete food.'
    end
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
