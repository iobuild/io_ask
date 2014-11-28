IoAsk::Engine.routes.draw do
  resources :topics

  resources :topics do
    resources :comments, :shallow => true
  end
end
