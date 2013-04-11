require 'spec_helper'

describe Tag do
  before { @tag = Tag.new(name: 'Sample') }
  subject { @tag }

  describe "API" do
    it { should respond_to(:name) }
    it { should respond_to(:freq) }
    it { should respond_to(:articles) }
    it { should be_valid }
  end

  describe "name" do
    it "should not be blank" do
      @tag.name = '   '
      @tag.should_not be_valid
    end

    it "should be less or equal to 50 characters" do
      @tag.name = 't'*51
      @tag.should_not be_valid
    end
  end

  describe "frequency" do
    subject { @tag.freq }
    it { should == 0 }

    it "should increase when an article is tagged" do
      pending
    end

    it "should decrease when an article is untagged" do
      pending
    end
  end
end
