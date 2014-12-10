IoAsk::Engine.routes.draw do
  root :to => "topics#index"

  resources :topics

  resources :topics do
    resources :comments, :shallow => true
  end
end
