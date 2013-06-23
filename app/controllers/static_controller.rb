class StaticController < ApplicationController
  def about
    lang = cookies[:lang] == 'ja' ? 'ja' : 'en'
    path = Rails.root.join('public', lang, "about.md")
    @md = IO.read(path)
  end

  def portfolio
  end

  def resume
    lang = cookies[:lang] == 'ja' ? 'ja' : 'en'
    path = Rails.root.join('public', lang, "resume.md")
    @md = IO.read(path)
  end
end
