Rails.application.routes.draw do
  get 'oauth/twitter'
  root 'pages#home'
end
