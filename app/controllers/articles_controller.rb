class ArticlesController < ApplicationController
  def list
    @articles = Article.paginate(params[:page], params[:locale])
    # FIXME: use HTTP header accept-language instead of cookies.
  end

  # TODO: All of this get logic should be DRY'ed to the model.
  def show
    @article = Article.filter(params[:locale]).where(:slug => params[:slug]).first!
  end

  def raw
    @article =  Article.filter(params[:locale]).where(:slug => params[:slug]).first!
    render :layout => false, :content_type => 'text/x-markdown; charset=utf-8'
  end
end
