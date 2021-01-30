Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'

  get 'fusion', to: 'junction_records#fusion'

  get 'identical', to: 'junction_records#identical'

  get 'filter', to: 'junction_records#filter'

  get 'csv_import', to: 'csv_imports#csv_import'

  resources :first_table_records, only: [:index]

end
