require "spec_helper"

describe "tags" do
  subject { page }
  before(:all) do
    @article = Article.from_file('sample')
    @tags = @article.tags
   end

  after(:all) { @article.destroy }

  describe "should list articles tagged under them" do
    before { visit tag_path(nil, @tags.first) }
    it { should have_link(@article.title) }
    it { page.status_code.should ==  200 }
  end
end
