Rails.application.routes.draw do
  resources :item_taxes
  resources :items do
   collection do
   	put :total_result
  end
  end	
  resources :item_categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
