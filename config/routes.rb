Rails.application.routes.draw do
  get 'amounts/parse'
  get 'dates/parse'
  get 'payment_methods/parse'
  get 'cryptos/get_latest_quotes_for'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
