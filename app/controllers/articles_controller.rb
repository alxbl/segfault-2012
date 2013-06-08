class ArticlesController < ApplicationController
  def list
    @articles = Article.where(lang: cookies[:lang] == 'ja' ? 2 : 1)
      .order("created_at DESC")
      .paginate(:page => params[:page], :per_page => 6)
  end

  def show
    @article = Article.where(slug: params[:slug], lang: cookies[:lang] == 'ja' ? 2 : 1).limit 1
  end
end
