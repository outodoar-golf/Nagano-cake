class SearchesController < ApplicationController
  def search
    if params[:tag_name].present?
      @content = params[:tag_name]
      record = Genre.find_by(name: @content)
      @record = Food.where(genre_id: record.id)
    else
      @content = params[:content]
      @record = search_for(@content)
    end
  end
  def tag_search

  end

  private
  def search_for(content)
    # 部分一致検索
    Food.where('name like ?','%'+content+'%')
  end

end
