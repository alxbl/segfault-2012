require 'spec_helper'

describe "error" do
  subject { page }

  describe "404 not found" do
    before do
      @path = "this_should_not_exist"
      visit "/#{@path}"
    end

    it { page.driver.status_code.should == 404 }
    it { should have_content('404') }
  end

  describe "503 unavailable" do
    before { visit '/503' }
    it { page.driver.status_code.should == 503 }
    it { should have_content('503') }
  end

  describe "500 internal error" do
    before { visit '/500' }
    it { page.driver.status_code.should == 500 }
    it { should have_content('500') }
  end
end
