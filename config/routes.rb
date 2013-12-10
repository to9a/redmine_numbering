# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :projects do
    resources :numbering_prefixes
    resources :numbering_prefixes_categories
    resources :numbering_prefixes_kinds
    resources :numbering_prefixes_partners
    resources :numbering_items
  end
end