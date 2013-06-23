class StaticController < ApplicationController
  def about
  end

  def portfolio
  end

  def resume
    lang = cookies[:lang] == 'ja' ? 'ja' : 'en'
    path = Rails.root.join('public', lang, "resume.md")
    @md = IO.read(path)
    p @md
  end
end
