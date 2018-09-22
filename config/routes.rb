Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resource :async
  resource :status
  resource :n_plus_one, controller: :n_plus_one
  resource :async_status
  resource :update_status
  resource :search_user_of_index, controller: :search_user_of_index
  resource :solved_n_plus_one, controller: :solved_n_plus_one
  resource :unsolved_n_plus_one, controller: :unsolved_n_plus_one
  resource :after_lock_table_of_comments
  resource :locking_in_transaction, controller: :locking_in_transaction

  namespace :api do
    resource :locking_in_transaction, controller: :locking_in_transaction
    resource :n_plus_one, controller: :n_plus_one
    resource :shoot_dice, controller: :shoot_dice
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
