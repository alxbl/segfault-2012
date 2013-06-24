SegfaultMe::Application.routes.draw do
  SLUG_REGEX   = /[a-z\-]+/i
  PAGE_REGEX   = /\d+/
  TAG_REGEX    = %r{[^-\.'"\\/+&@#$\^&*]+}
  LOCALE_REGEX = /ja/

  scope "/(:locale)", :locale => LOCALE_REGEX do
    match 'about' => 'static#about'
    match 'portfolio' => 'static#portfolio'
    match 'resume' => 'static#resume'

    resources :tags, only: [:show], :constraints => { id: TAG_REGEX }

    # Manual routes to avoid resources.
    match 'page/:page' => 'articles#list', :constraints => { page: PAGE_REGEX }, as: :page, :defaults => { page: 1 }
    match 'posts/:slug' => 'articles#show', :constraints => { slug: SLUG_REGEX }, as: :article
    match 'posts/raw/:slug' => 'articles#raw', :constraints => { slug: SLUG_REGEX }, as: :raw

    match '/404', :to => 'errors#error_404'
    match '/500', :to => 'errors#error_500'
    match '/503', :to => 'errors#error_503'
    root :to => 'articles#list'
  end
end
