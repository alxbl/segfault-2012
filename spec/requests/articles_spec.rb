# -*- coding: utf-8 -*-
require 'spec_helper'

describe "blog page" do
  subject { page }
  before(:each) { visit root_path(nil) }

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
      Article.paginate(1).each do |article|
        page.should have_selector('article h2', text: article.header)
      end
      page.should have_link('Older')
    end

    it "should paginate older articles" do
      click_link "Older"
      Article.paginate(2, :en).each do |article|
        page.should have_selector('article h2', text: article.header)
      end
      page.should have_link('Newer') # We should be able to go back.
    end
  end

  describe "article view" do
    before(:all) do
      @article = FactoryGirl.create(:article)
      @article.md = "# Header\n## Subheader\n\n* Bullet\n* Bullet\n* Bullet\n\n"
      @md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true) # For a test case.
      @article.add_tag Tag.from_name("Tag1")
      @article.add_tag Tag.from_name("Tag2")
      @article.html = @md.render(@article.md)
      @article.save
    end

    before(:each) { visit article_path(nil, @article) }
    after(:all) { Article.delete_all }

    it "should render as markdown when the body is displayed." do
      page.should have_content(@article.header)
      page.should have_content(@article.date)
      page.should have_selector('article h1', text: 'Header')
      page.should have_selector('article h2', text: 'Subheader')
      page.should have_selector('li', text: 'Bullet')
    end

    it "should link to the raw markdown" do
      should have_link("raw")
    end

    it "should link tags" do
      should have_link("Tag1")
      should have_link("Tag2")
    end
  end

  describe "language" do
    before(:all) do
      @en = Article.from_file('sample', 'en')
      @ja = Article.from_file('sample', 'ja')
    end
    after(:all) do
      Article.delete_all
    end

    it "should default to English list" do
      visit root_path(nil)
      page.should have_content "Sample Title"
      page.should_not have_content "タイトル"
    end

    it "should default to English show" do
      visit article_path(nil, @en)
      page.should have_content "Sample Title"
      page.should_not have_content "タイトル"
    end
  end
end
