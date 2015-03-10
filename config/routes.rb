IoAsk::Engine.routes.draw do
  root :to => "topics#index"

  resources :topics

  resources :topics do

    collection do
      get 'category/:cid', to: 'topics#index'
    end

    resources :comments, :shallow => true
  end
end
