require 'spec_helper'

describe Comment do
  before do
    @article = FactoryGirl.create(:article)
    @comment = Comment.new(body: 'Test Comment')
    @comment.article = @article
  end
  subject { @comment }

  describe "API" do
    it { should respond_to(:article) }
    it { should respond_to(:body) }
    it { should respond_to(:flagged) }
    it { should respond_to(:author) }
    it { should be_valid }
  end

  describe "body" do
    it "has at most 300 chracters" do
      @comment.body = 'a'*301
      @comment.should_not be_valid
    end
  end

  it "should always point to an article" do
    @comment.article_id = nil
    @comment.should_not be_valid
  end
end
