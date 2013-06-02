SegfaultMe::Application.routes.draw do
  # TODO: article resources
  match 'about' => 'static#about'
  match 'portfolio' => 'static#portfolio'
  match 'resume' => 'static#resume'

  # Manual routes to avoid resources.
  match 'page/:page' => 'articles#list', :constraints => { page: /\d+/ }, as: :page
  match 'posts/:slug' => 'articles#show', :constraints => { slug: /[a-z\-]+/i }, as: :article
  root :to => 'articles#list', :defaults => { page: 1 }
end
