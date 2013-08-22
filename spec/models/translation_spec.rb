# -*- coding: utf-8 -*-
require 'spec_helper'

describe Translation do
  before do
    @article = FactoryGirl.create(:article)
    @translations = @article.translations
    @translation1 = @translations.first
  end
  subject { @translation1 }

  describe "API" do
    it { should respond_to(:markdown) }
    it { should respond_to(:html_cache) }
    it { should respond_to(:header) }
    it { should respond_to(:language) }
    it { should respond_to(:article) }
  end

  it "should be unique" do
    @duplicate = @translation1.dup
    expect { @duplicate.save }.to raise_error
  end

  describe "markdown should not be empty" do
    before { @translation1.markdown = ' ' }
    it { should_not be_valid }
  end

  describe "html should not be empty" do
    before { @translation1.html_cache = ' ' }
    it { should_not be_valid }
  end

  describe "header" do
    describe "should not be empty" do
      before { @translation1.header = '' }
      it { should_not be_valid }
    end

    describe "length <= 255" do
      before { @translation1.header = 'a'*300 }
      it { should_not be_valid }
    end
  end

  it "should be deleted when article is deleted" do
    a = FactoryGirl.create(:article)
    a.translations.count.should == 2
    tids = a.translations.map { |t| t.id }
    a.destroy
    tids.each { |t| expect { Translation.find_by_id! t }.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
