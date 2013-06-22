require "spec_helper"

describe "tags" do
  subject { page }
  before do
    @article = Article.from_file('sample', 'en')
    @taggings =@article.taggings
    @tags = @taggings.map { |t| t.tag }
  end

  describe "should list articles tagged under them" do
    before { visit tag_path(@tags.first) }
    it { should have_link(@article.header) }
  end
end
