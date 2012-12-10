Railstmp::Application.routes.draw do
  resources :tmps # いずれ廃止
  root :to => 'tmps#index'
end
