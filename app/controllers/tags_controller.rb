class TagsController < ApplicationController

  def index
    # Tag cloud or something
  end
  def show
    @tag = Tag.find_by_name! params[:id]
    @articles = @tag.articles
    @title = @tag.name
  end
end
