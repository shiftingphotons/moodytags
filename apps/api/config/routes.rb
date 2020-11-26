# frozen_string_literal: true

get '/ping', to: ->(env) { [200, {}, ['pong']] }

# V1
get '/api/v1/tag_collections', to: 'tag_collections#index'
put '/api/v1/tag_collections', to: 'tag_collections#update'

get '/api/v1/taggables', to: 'taggables#index'
post '/api/v1/taggables', to: 'taggables#create'
patch '/api/v1/taggables/:id', to: 'taggables#update'

get '/api/v1/playlists', to: 'spotify#get_playlists'

# Auth
get '/auth/spotify/callback', to: 'auth#spotify'
