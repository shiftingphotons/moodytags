# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
get '/ping', to: ->(env) { [200, {}, ['pong']] }

# V1
get '/taggables', to: 'taggables#index'
patch '/taggables/:id', to: 'taggables#update'
