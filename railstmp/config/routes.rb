Railstmp::Application.routes.draw do
  #resources :tmps # いずれ廃止
  #url :コントローラー => アクション
  # http://kiyorin-net.blogspot.jp/2011/04/rails3-routes.html
  
  # tmps  /tmps(.:format) tmps#index
  #match "tmps" => "tmps#index" , :as => :tmps
  
  # tmps_index  /tmps/index(.:format) tmps#index
  #match "tmps/index" 
  
  # tmps  /tmps(.:format) tmps#index
  #match "tmps" => "tmps#index"
  
  # ano  /tmps(.:format) tmps#index
  #match "tmps" => "tmps#index", :as => "ano"
  
  get "tmps" => "tmps#index", :as => "tmps"
  post "tmps" => "tmps#create"
  get "tmps/new" => "tmps#new", :as => "new_tmp"
  get "tmps/:id/edit" => "tmps#edit", :as => "edit_tmp"
  get "tmps/:id" => "tmps#show", :as => "tmp"
  put "tmps/:id" => "tmps#update"
  delete "tmps/:id" => "tmps#destroy"
  
  root :to => 'tmps#index'
end

=begin
# resources
    tmps GET    /tmps(.:format)          tmps#index
         POST   /tmps(.:format)          tmps#create
 new_tmp GET    /tmps/new(.:format)      tmps#new
edit_tmp GET    /tmps/:id/edit(.:format) tmps#edit
     tmp GET    /tmps/:id(.:format)      tmps#show
         PUT    /tmps/:id(.:format)      tmps#update
         DELETE /tmps/:id(.:format)      tmps#destroy
    root        /                        tmps#index
=end

=begin
# てづくり
    tmps GET    /tmps(.:format)          tmps#index
         POST   /tmps(.:format)          tmps#create
 new_tmp GET    /tmps/new(.:format)      tmps#new
edit_tmp GET    /tmps/:id/edit(.:format) tmps#edit
     tmp GET    /tmps/:id(.:format)      tmps#show
         PUT    /tmps/:id(.:format)      tmps#update
         DELETE /tmps/:id(.:format)      tmps#destroy
    root        /                        tmps#index
=end




