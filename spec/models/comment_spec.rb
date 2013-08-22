require 'spec_helper'

describe Comment do
  before do
    @article = FactoryGirl.create(:article)
    @comment = Comment.new(body: 'Test Comment')
    @comment.translation = @article.translations.first
  end
  subject { @comment }

  describe "model" do
    it { should respond_to(:translation) }
    it { should respond_to(:body) }
    it { should respond_to(:flagged) }
    it { should respond_to(:author) }
    it { should be_valid }
  end

  describe ".body" do
    it "has at most 300 characters" do
      @comment.body = 'a'*301
      @comment.should_not be_valid
    end

    it "always points to an article translation" do
      @comment.translation_id = nil
      @comment.should_not be_valid
    end
  end
end
