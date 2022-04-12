Rails.application.routes.draw do
  root "vehicles#index"

  post 'filter', to: 'vehicles#filter', as: :vehicle_filter
  post 'import', to: 'vehicles#import', as: :vehicle_import
end
