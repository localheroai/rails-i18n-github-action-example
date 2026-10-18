Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "team_settings#show"
  end
end
