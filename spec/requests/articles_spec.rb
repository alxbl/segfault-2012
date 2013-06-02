require 'spec_helper'

describe "blog page" do
  subject { page }
  before(:each) { visit root_path }

  describe "footer" do
    it { should have_content('Newer') }
    it { should have_content('Older') }

    describe "no newer entries" do
      it { should_not have_link('Newer') }
    end

    describe "no older entries" do
      it { should_not have_link('Older') }
    end
  end

  describe "no articles available" do
    it { should have_selector('article', text: 'no articles') }
  end

  describe "article listing" do
    before(:all) { 8.times { FactoryGirl.create(:article) } }
    after(:all) { Article.delete_all }

    it "should paginate 6 per page." do

      Article.paginate(page: 1, per_page: 6).each do |article|
        page.should have_selector('article h2', text: article.header)
      end
      page.should have_link('Older')
    end

    it "should paginate older articles" do
      click_link "Older"
      Article.paginate(page: 2, per_page: 6).each do |article|
        page.should have_selector('article h2', text: article.header)
      end
      page.should have_link('Newer') # We should be able to go back.
    end
  end

  describe "article view" do
    before(:all) do
      @article = FactoryGirl.create(:article)
      @article.body = "# Header\n## Subheader\n\n* Bullet\n* Bullet\n* Bullet\n\n"
      @article.save
    end

    before(:each) { visit article_path(@article) }
    after(:all) { Article.delete_all }

    it "should render as markdown when the body is displayed." do
      page.should have_content(@article.header)
      page.should have_content(@article.date)
      page.should have_selector('article h1', text: 'Header')
      page.should have_selector('article h2', text: 'Subheader')
      page.should have_selector('li', text: 'Bullet')
    end
  end
end
