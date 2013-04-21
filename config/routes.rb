SegfaultMe::Application.routes.draw do
  # TODO: article resources
  match 'about' => 'static#about'
  match 'portfolio' => 'static#portfolio'
  match 'resume' => 'static#resume'

  match 'blog/page/:page' => 'blog#list', :constraints => ( page: /\d+/ }

  root :to => 'blog#list', :defaults => { page: 1 }
end
