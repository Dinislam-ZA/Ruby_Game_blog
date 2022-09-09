# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    get 'posts/new', to: 'posts#new'
    get 'posts/index'
    get 'posts/:id', to: 'posts#show', constraints: { id: /\d+/ }
    get 'posts/:topic', to: 'posts#topic'

    post 'posts/create', to: 'posts#create'
    get 'posts/edit/:id', to: 'posts#edit'
    post 'posts/update/:id', to: 'posts#update'

    get 'posts', to: 'posts#index'

    post 'comments/create/:post_id', to: 'comments#create', constraints: { post_id: /\d+/ }
    post 'comments/create/:post_id/replies/:parent_id', to: 'comments#create', constraints: { post_id: /\d+/, parent_id: /\d+/ }

    root to: 'posts#index'
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    devise_for :users
  end
end
