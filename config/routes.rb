Rails.application.routes.draw do
  post 'alexa', to: 'alexa#listener'
end
