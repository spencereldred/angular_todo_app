AngularTodo::Application.routes.draw do

  root to: "list#index"
  resources :todos
end
