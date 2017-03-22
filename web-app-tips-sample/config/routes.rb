Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :status
  resource :async_status
  resource :update_status
  resource :searching_user_not_use_index, controller: :searching_user_not_use_index
  resource :searching_user_use_index, controller: :searching_user_use_index
  resource :solved_n_plus_one, controller: :solved_n_plus_one
  resource :unsolved_n_plus_one, controller: :unsolved_n_plus_one
  resource :after_lock_table_of_comments
end
