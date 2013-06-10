SegfaultMe::Application.routes.draw do
  SLUG_REGEX = /[a-z\-]+/i
  match 'about' => 'static#about'
  match 'portfolio' => 'static#portfolio'
  match 'resume' => 'static#resume'

  resources :tags, only: [:index, :show]

  # Manual routes to avoid resources.
  match 'page/:page' => 'articles#list', :constraints => { page: /\d+/ }, as: :page, :defaults => { page: 1 }
  match 'posts/:slug' => 'articles#show', :constraints => { slug: SLUG_REGEX }, as: :article
  match 'posts/raw/:slug' => 'articles#raw', :constraints => { slug: SLUG_REGEX }, as: :raw
  root :to => 'articles#list'
end
