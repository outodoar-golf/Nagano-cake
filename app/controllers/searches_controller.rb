class SearchesController < ApplicationController
  def search
    @content = params[:content]
    @record = search_for(@content)
  end

  private
  def search_for(content)
    # 部分一致検索
    Food.where('name like ?','%'+content+'%')
  end

end
