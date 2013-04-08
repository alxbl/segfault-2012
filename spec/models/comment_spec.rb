require 'spec_helper'

describe Comment do
  before do
    @comment = Comment.new(body: 'Test Comment')
  end
  subject { @comment }

  describe "API" do
    it { should respond_to(:article) }
    it { should respond_to(:body) }
    it { should respond_to(:flagged) }
    it { should respond_to(:author) }
  end
end
