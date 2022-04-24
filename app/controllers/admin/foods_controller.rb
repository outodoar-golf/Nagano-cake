class Admin::FoodsController < ApplicationController
  def new
    @food = Food.new(session[:foods] || {})
    @genre = Genre.all
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      session[:foods] = nil
      redirect_to admin_food_path(@food.id)
    else
      session[:foods] = @food.attributes.slice(*food_params.keys)
      flash[:danger] = @food.errors.full_messages
      redirect_to new_admin_food_path
    end
  end

  def index
    @foods = Food.all.page(params[:page]).per(10)
  end

  def show
    @food = Food.find(params[:id])
    # 消費税
    @tax = 1.1
  end

  def edit
    @food = Food.find(params[:id])
    @genre = Genre.all
  end

  def update
    @food = Food.find(params[:id])
    if @food.update(food_params)
      # もし販売停止中であれば
      if @food.sale_status == false
        cart_food = CartFood.where(food_id: @food.id)
        cart_food.destroy_all
      end
      redirect_to admin_food_path(@food.id)
    else
      flash[:danger] = @food.errors.full_messages
      redirect_to edit_admin_food_path(@food.id)
    end
  end

  private
  def food_params
    params.require(:food).permit(:name,:explanation,:genre_id,:price,:sale_status,:image)
  end
end
