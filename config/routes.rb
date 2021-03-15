Rails.application.routes.draw do

  root 'projects#index', as: 'index'

  resources :projects do
    resources :tasks
  end

  post 'tasks/complete_task' => 'tasks#complete_task'

  post 'tasks/update_positions' => 'tasks#update_positions'

end
