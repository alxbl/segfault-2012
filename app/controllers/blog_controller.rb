class BlogController < ApplicationController
  def list
    @articles = Article.paginate(:page => params[:page], :per_page => 6)
  end
end
