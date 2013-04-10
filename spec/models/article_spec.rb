require 'spec_helper'

describe Article do
  before do
    @article = Article.new(slug: "test-article", body: "Hello World", header: "Header", allow_comments: true)
    @article.save
  end
  subject { @article }

  describe "API" do
    it { should respond_to(:slug) }
    it { should respond_to(:body) }
    it { should respond_to(:header) }
    it { should respond_to(:allow_comments) }
    it { should respond_to(:tags) }
    it { should respond_to(:comments) }
  end

  describe "slug" do
    describe "is required" do
      before { @article.slug = '' }
      it { should_not be_valid }
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
      pending
    end

    describe "length <= 255" do
      before { @article.slug = "a"*300 }
      it { should_not be_valid }
    end
  end

  describe "body should not be empty" do
    before { @article.body = ' ' }
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

end
