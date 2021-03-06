class Public::FoodsController < ApplicationController
  def index
    @foods = Food.where(sale_status: false).page(params[:page]).per(10)
    @genres = Genre.all
  end
  def show
    @food = Food.find(params[:id])
    @cart_food = CartFood.new
    @genres = Genre.all
  end
end
