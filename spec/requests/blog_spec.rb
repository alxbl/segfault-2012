require 'spec_helper'

describe "blog page" do
  subject { page }
  before { visit root_path }

  describe "footer" do
    it { should have_content('Newer') }
    it { should have_content('Older') }

    describe "no newer entries" do
    pending
    end

    describe "no older entries" do
    pending
    end
  end

  describe "no articles available" do
  pending
  end

  describe "article listing" do
    # before do # Create a few articles
    # end
    #it { should have_selector('article', text: :article1.date.to_s) }
    #it { should have_selector('article', text: :article1.header) }

    # Extra article that goes on next page.
  pending
  end
end
