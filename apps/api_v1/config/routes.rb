# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
get '/ping', to: ->(env) { [200, {}, ['pong']] }

# V1
get '/api/v1/taggables', to: 'taggables#index'
patch '/api/v1/taggables/:id', to: 'taggables#update'

# Auth
get '/auth/spotify/callback', to: 'auth#spotify'
