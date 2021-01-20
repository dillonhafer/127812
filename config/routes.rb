Rails.application.routes.draw do
  resources :super_magic_links, path: "🍄", only: %i[new create index] do
    member do
      get :open
    end
  end

  devise_for :user, path: "/", path_names: {
    sign_in: "sign-in",
    sign_out: "sign-out",
    sign_up: "sign-up",
    registration: "registration"
  }

  root to: "dashboard#index"
end
