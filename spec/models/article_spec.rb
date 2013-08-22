# -*- coding: utf-8 -*-
require 'spec_helper'

describe Article do
  describe "model" do
    before(:all) { @a = FactoryGirl.build(:article) }
    after(:all) { @a.destroy }
    subject { @a }

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

    describe ".slug" do
      it "is required" do
        @a.slug = ''
        @a.should_not be_valid
      end

      it "is well formatted" do
        invalid_slugs = %w[numbers-323-are-invalid
                         -starts-with-dash
                         ends-with-dash-
                         symbols_are!invalid+too.
                         double--dash
                         source-is-in-router.md]
        valid_slugs = %w[simple-slug nodashslug a a-b a-rather-long-slug-is-okay]

        invalid_slugs.each do |s|
          @a.slug = s
          @a.should_not be_valid
        end

        valid_slugs.each do |s|
          @a.slug = s
          @a.should be_valid
        end
      end

      it "is at most 255 characters" do
        @a.slug = "a"*300
        should_not be_valid
      end
    end
  end

  describe ".from_file" do
    before(:all) { @article = Article.from_file('sample') }
    after(:all) { @article.destroy }
    subject { @article }
    it "loads translations properly" do
      @article.translations.count.should == 2
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
