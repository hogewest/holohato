Rails.application.routes.draw do
  root "home#index"
  get "jobs", to: "jobs#index"
  get "search", to: "search#search"
  get "videos/:video_id", to: "videos#show"

  get "up" => "rails/health#show", as: :rails_health_check
end
