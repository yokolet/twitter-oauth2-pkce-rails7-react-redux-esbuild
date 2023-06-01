Rails.application.routes.draw do
  get 'oauth/twitter'
  root 'pages#home'
  get 'me', action: :profile, controller: 'me'
end
