class Admin::GenresController < ApplicationController
  def new
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
     if @genre.save
       redirect_to  new_admin_genre_path,notice:'ジャンル追加しました'
     else
       flash[:danger] = @genre.errors.full_messages
       redirect_to new_admin_genre_path
     end
  end
  def edit
    @genre = Genre.find(params[:id])
  end
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to new_admin_genre_path,notice:'変更しました'
    else
      flash[:danger] = @genre.errors.full_messages
      redirect_to new_admin_genre_path
    end
  end


  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
