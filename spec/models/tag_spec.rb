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
    before do
      @tag.save
      @article1 = FactoryGirl.create(:article)
      @article2 = FactoryGirl.create(:article)
    end

    after(:each) { Tagging.delete_all }

    it "should start at 0" do
      @tag.freq.should == 0
    end

# Lol counter_cache. Sure. TODO: Uncomment when a working alternative exists
# (i.e. whenever I bother to implement caching manually. Meh.)
#    it "should increase when an article is tagged" do
#      @article2.add_tag @tag
#      @tag.freq.should == 1
#    end

#
#    it "should decrease when an article is untagged" do
#      @article1.add_tag @tag
#      should == 1
#      @article1.remove_tag @tag
#      should == 0
#    end

#    it "should not allow duplicate tags" do
#      @article1.add_tag @tag
#      should == 1
#      @article1.add_tag @tag
#      should == 1
#    end
  end
end
