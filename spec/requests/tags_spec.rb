require "spec_helper"

describe "tags" do
  subject { page }
  before do
    I18n.locale = :en
    @article = Article.from_file('sample', 'en')
    @taggings =@article.taggings
    @tags = @taggings.map { |t| t.tag }
  end

  describe "should list articles tagged under them" do
    before { visit tag_path(nil, @tags.first) }
    it { should have_link(@article.header) }
  end
end
