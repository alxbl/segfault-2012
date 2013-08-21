# -*- coding: utf-8 -*-
require 'spec_helper'

describe Article do
  before do
    @article = FactoryGirl.create(:article)
  end
  subject { @article }

  describe "API" do
    it { should respond_to(:slug) }
    it { should respond_to(:allow_comments) }
    it { should respond_to(:date) }
    it { Article.should respond_to(:page) }

    # Translation abstraction API
    it { should respond_to(:tags) }
    it { should respond_to(:title) }
    it { should respond_to(:content) }
    it { should respond_to(:comments) }
    it { Article.constants(false).include?(:RSS_CACHE).should == true }
  end

  describe "slug" do
    it "is required" do
      @article.slug = ''
      @article.should_not be_valid
    end

    it "should be well formatted" do
      invalid_slugs = %w[numbers-323-are-invalid
                         -starts-with-dash
                         ends-with-dash-
                         symbols_are!invalid+too.
                         double--dash
                         source-is-in-router.md]
      valid_slugs = %w[simple-slug nodashslug a a-b a-rather-long-slug-is-okay]

      invalid_slugs.each do |s|
        @article.slug = s
        @article.should_not be_valid
      end

      valid_slugs.each do |s|
        @article.slug = s
        @article.should be_valid
      end
    end

    it "should be less than 255 characters long" do
      @article.slug = "a"*300
      should_not be_valid
    end
  end

  describe "parsing from file" do
    before do
      @article = Article.from_file('sample')
    end

    describe "loads translations properly" do
      it { @article.translations.count.should == 2 }
    end

    it "loads markdown properly" do
      @article.translations.each do |t|
        t.markdown.should =~ /#/
      end
    end

    it "renders html properly" do
      @article.translations.each do |t|
        t.html_cache.should =~ /<h1>/
      end
    end

    it "loads tags properly" do
      @article.translations.each do |t|
        t.taggings.size.should == 2
      end
    end

    it "loads header properly" do
      @article.translations.each do |t|
        t.header.should_not be_blank
      end
    end

    it "loads slug properly" do
      @article.slug.should == "sample"
    end
  end
end
