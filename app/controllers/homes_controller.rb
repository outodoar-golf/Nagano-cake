class HomesController < ApplicationController
  def top
    @genres = Genre.all
    @foods = Food.order(:created_at).limit(4)
  end
  def about
  end
end
