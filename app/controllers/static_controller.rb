class StaticController < ApplicationController
  def about
    path = Rails.root.join('public', I18n.locale.to_s, "about.md")
    @md = IO.read(path)
  end

  def portfolio
  end

  def resume
    path = Rails.root.join('public', I18n.locale.to_s, "resume.md")
    @md = IO.read(path)
  end
end
