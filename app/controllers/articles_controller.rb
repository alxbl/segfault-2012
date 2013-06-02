class ArticlesController < ApplicationController
  def list
    @articles = Article.paginate(:page => params[:page], :per_page => 6)
  end

  def show
    @article = Article.find_by_slug(params[:slug])
  end
end
