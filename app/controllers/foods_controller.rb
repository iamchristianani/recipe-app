class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      redirect_to foods_path, notice: 'Food was successfully saved.'
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])

    # authorize! :destroy, @food

    if @food.destroy
      flash[:success] = 'Food deleted successfully.'
      redirect_to foods_path
    else
      flash[:error] = 'Failed to delete food.'
      redirect_to foods_path
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
