class ArticlesController < ApplicationController
  def list
    @articles = Article.page(params[:page])
    # FIXME: use HTTP header accept-language instead of cookies.
  end

  def show
    @article = Article.where(:slug => params[:slug]).first!
  end

  def raw
    @article =  Article.where(:slug => params[:slug]).first!
    render :layout => false, :content_type => 'text/x-markdown'
  end

  def rss
    @articles = Article.order('created_at DESC').limit(10)
    render :layout => false, :content_type => 'application/xml'
  end
end
