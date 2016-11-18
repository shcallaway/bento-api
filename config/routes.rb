Rails.application.routes.draw do
  namespace :v1, defaults: { format: 'json' } do
    resources :tracks
    resources :api_keys, only: [ :create ]
  end

  # To add another version, create a new namespace:

  # namespace :v2 do
  #   resources :tracks
  #   resources :api_keys, only: [ :create ]
  # end

  # Copy the v1 directory to a v2 directiory,
  # and change the module names to V2.

  # For more information and potential improvements, see:
  # http://railscasts.com/episodes/350-rest-api-versioning?autoplay=true
  # http://railscasts.com/episodes/352-securing-an-api?autoplay=true

end
