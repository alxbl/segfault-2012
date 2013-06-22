class ArticlesController < ApplicationController
  def list
    @articles = Article.paginate(params[:page])
                       .where(lang: cookies[:lang] == 'ja' ? 2 : 1)
    # FIXME: use HTTP header accept-language instead of cookies.
  end

  # TODO: All of this get logic should be DRY'ed to the model.
  def show
    @article = Article.where(slug: params[:slug], lang: cookies[:lang] == 'ja' ? 2 : 1).limit(1).first!
  end

  def raw
    @article =  Article.where(slug: params[:slug], lang: cookies[:lang] == 'ja' ? 2 : 1).limit(1).first!
    render :layout => false, :content_type => 'text/x-markdown; charset=UTF-8'
  end
end
