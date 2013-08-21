class TagsController < ApplicationController

  def index
    # Tag cloud or something
  end

  def show
    @articles = Article.joins({translations: { taggings: :tag }}).where("tags.name = '#{params[:id]}'")
    @title = params[:id]
  end
end
