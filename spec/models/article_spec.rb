# -*- coding: utf-8 -*-
require 'spec_helper'

describe Article do
  before do
    @article = Article.new(slug: "test-article", md: "#Hello World", html: "<h1>Hello World</h1>", header: "Header", allow_comments: true)
    @article.save
  end
  subject { @article }

  describe "API" do
    it { should respond_to(:slug) }
    it { should respond_to(:md) }
    it { should respond_to(:html) }
    it { should respond_to(:header) }
    it { should respond_to(:allow_comments) }
    it { should respond_to(:tags) }
    it { should respond_to(:comments) }
    it { should respond_to(:date) }
    it { should respond_to(:lang) }
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

    describe "should be unique" do
      before { @duplicate = Article.new(slug: "test-article", md: "#Duplicate Article", html: "<h1>Duplicate Article</h1>", header: "Header") }
      subject { @duplicate }
      it { should_not == @duplicate.save }
    end

    describe "length <= 255" do
      before { @article.slug = "a"*300 }
      it { should_not be_valid }
    end
  end

  describe "markdown should not be empty" do
    before { @article.md = ' ' }
    it { should_not be_valid }
  end

  describe "html should not be empty" do
    before { @article.html = ' ' }
    it { should_not be_valid }
  end

  describe "header" do
    describe "should not be empty" do
      before { @article.header = '' }
      it { should_not be_valid }
    end

    describe "length <= 255" do
      before { @article.header = 'a'*300 }
      it { should_not be_valid }
    end
  end

  describe "parsing from file" do
    before do
      @article_en = Article.from_file('sample', 'en')
      @article_ja = Article.from_file('sample', 'ja')
    end

    describe "loads markdown properly" do
      it { @article_en.md.should == "# Sample" }
      it { @article_ja.md.should == "# サンプル" }
    end

    describe "renders html properly" do
      it { @article_en.html.should == "<h1>Sample</h1>" }
      it { @article_ja.html.should == "<h1>サンプル</h1>" }
    end

    describe "loads tags properly" do
      it { @article_en.taggings.size.should == 2 }
      it { @article_en.taggings.first.name.should == "Tag" }
    end

    describe "loads header properly" do
      it { @article_en.header.should == "Sample Title" }
    end

    describe "loads slug properly" do
      it { @article_en.slug.should == "sample" }
    end
  end
end
