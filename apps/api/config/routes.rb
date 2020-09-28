get '/ping', to: ->(env) { [200, {}, ['pong']] }

# V1
get '/api/v1/user/tags', to: 'user#get_tags'

get '/api/v1/taggables', to: 'taggables#index'
post '/api/v1/taggables', to: 'taggables#create'
patch '/api/v1/taggables/:id', to: 'taggables#update'

get '/api/v1/playlists', to: 'spotify#get_playlists'

# Auth
get '/auth/spotify/callback', to: 'auth#spotify'
