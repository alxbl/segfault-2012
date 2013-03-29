require 'spec_helper'
###
# Static content
###
describe "Site layout" do
  subject { page }
  before { visit root_path }
  
  it { should have_selector('header') }
  it { should have_css('a.logo img') }
  it { should have_css('ul.main-nav') }
  it { should have_css('ul li.nav-home') }
  it { should have_css('ul li.nav-about') }
  it { should have_css('ul li.nav-portfolio') }
  it { should have_css('ul li.nav-resume') }
  it { should have_selector('a', text: 'GitHub') }
  
  # Title
  it { should have_selector('h1', text: 'Segmentation Fault')}
  
  # Language
  it { should have_css('ul.lang-nav') }
  it { should have_css('a.en') }
  it { should have_css('a.ja') }
  
  it { should have_selector('footer') }
end