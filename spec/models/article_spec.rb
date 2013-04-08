require 'spec_helper'

describe Article do
  before { @article = Article.new(slug: "test-article", body: "Hello World", header: "Header", allow_comments: true) }
  subject { @article }

  describe "API" do
    it { should respond_to(:slug) }
    it { should respond_to(:body) }
    it { should respond_to(:header) }
    it { should respond_to(:allow_comments) }
    it { should respond_to(:tags) }
    it { should respond_to(:comments) }
  end

  describe "slug should be unique" do
  end

  describe "slug length <= 255" do
  end

  describe "should have valid content" do
  end
end
