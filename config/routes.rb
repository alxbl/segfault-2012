SegfaultMe::Application.routes.draw do
  # TODO: article resources
  match 'about' => 'static#about'
  match 'portfolio' => 'static#portfolio'
  match 'resume' => 'static#resume'

  # Manual routes to avoid resources.
  match 'page/:page' => 'blog#list', :constraints => { page: /\d+/ }, as: :page
  match 'posts/:slug' => 'blog#view', :constraints => { slug: /[a-z\-]+/i }, as: :article

  root :to => 'blog#list', :defaults => { page: 1 }
end
