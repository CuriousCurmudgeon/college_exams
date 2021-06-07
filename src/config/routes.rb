Rails.application.routes.draw do
  post 'assigned_exams', to: 'assigned_exams#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
