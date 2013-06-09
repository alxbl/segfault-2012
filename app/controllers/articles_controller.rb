class ArticlesController < ApplicationController
  def list
    @articles = Article.where(lang: cookies[:lang] == 'ja' ? 2 : 1)
      .order("created_at DESC")
      .paginate(:page => params[:page], :per_page => 6)
  end

  # TODO: All of this get logic should be DRY'ed to the model.
  def show
    @article = Article.where(slug: params[:slug], lang: cookies[:lang] == 'ja' ? 2 : 1).limit 1
  end

  def raw
    @article =  Article.where(slug: params[:slug], lang: cookies[:lang] == 'ja' ? 2 : 1).limit(1).first || not_found
    render :layout => false, :content_type => 'text/x-markdown; charset=UTF-8'
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
