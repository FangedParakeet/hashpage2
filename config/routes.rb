Hashpage::Application.routes.draw do

  root :to => "hpage#index"
  get '/hpage/show', :controller => 'hpage', :action => 'show'
end
