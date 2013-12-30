# -*- coding: utf-8 -*-
require 'spec_helper'

describe "blog" do
  subject { page }
  #before(:all) { Article.delete_all }

  describe "#index no articles" do
    before { visit root_path(nil) }
    it { should have_selector('article', text: 'no articles') }
    it { should have_content('Newer') }
    it { should have_content('Older') }
    it { should_not have_link('Newer') }
    it { should_not have_link('Older') }
  end

  describe "with articles" do
    before(:all) do
      8.times { FactoryGirl.create(:article) }
      @sample = Article.from_file('sample')
    end
    after(:all) { Article.delete_all }

    describe "#index" do
      before { visit root_path(nil) }

      it "should follow locale" do
        visit root_path(:ja)
        page.should have_content 'タイトル'
      end

      it "should paginate 6 per page." do
        Article.page(1).each do |article|
          page.should have_selector('article h2', text: article.title)
        end
        page.should have_link('Older')
      end

      it "should paginate older articles" do
        click_link "Older"
        Article.page(2).each do |article|
          page.should have_selector('article h2', text: article.title)
        end
        page.should have_link('Newer') # We should be able to go back.
      end
    end

    describe "#show" do
      before { visit article_path(nil, @sample) }

      it "should render as markdown when the body is displayed." do
        page.should have_content(@sample.title)
        page.should have_content(@sample.date)
        page.should have_selector('article h1', text: 'Sample')
        page.should have_selector('ol', text: 'Number List')
        page.should have_selector('li', text: 'List')
      end

      it "should include the article title in page title" do
        visit article_path(nil, @sample)
        page.should have_selector('html head title', text: @sample.title)
      end

      it "should follow locale" do
        visit article_path(:ja, @sample)
        should have_content 'タイトル'
      end

      it "should link to the raw markdown" do
        should have_link("raw")
      end

      it "should link tags" do
        should have_link("Tag")
        should have_link("Sample")
      end
    end

    describe "language" do
      it "defaults to English list" do
        visit root_path(nil)
        page.should have_content "Sample Title"
        page.should_not have_content "タイトル"
      end

      it "defaults to English show" do
        visit article_path(nil, @sample)
        page.should have_content "Sample Title"
        page.should_not have_content "タイトル"
      end
    end

    describe "#raw" do
      before { visit raw_path(nil, @sample) }
      it "follows locale" do
        visit raw_path(:ja, @sample)
        should have_content 'サンプル'
      end

      it "displays markdown" do
        page.status_code.should == 200
      end
    end

    describe "#rss" do
      it "should have the rss structure" do
        selectors = ['rss', 'rss channel title', 'rss channel description', 'rss channel link', 'rss channel language']
        [nil, :ja].each do |l|
          visit rss_path(l)
          selectors.each { |s| should have_selector s }
          should have_content(@sample.title)
          should have_content(article_path(l, @sample))
        end
      end

      it "should cache articles" do
        #new_article = FactoryGirl.create(:article)
        #visit rss_path(@locales.first)
        #should_not have_content new_article.header
        pending # Caching is not enabled by default in test
      end

      it "should invalidate the cache when a new article is added" do
        pending
      end

    end
  end
end
