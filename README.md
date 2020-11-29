<p align="center">
  <a href="https://moodytags.shiftingphotons.dev"><img src="public/gh_logo.png" width="240"/></a>
</p>

---  

<p align="center">
  <strong>Tag your playlist collection</strong></br>
  Moodytags is trying to help you sort your collection of playlists better.</br>Providing a possible answer to the <strong>"What should I listen to now?"</strong> question.</br></br>
  <img src="https://img.shields.io/github/v/release/shiftingphotons/moodytags?include_prereleases"/>
  <img src="https://img.shields.io/github/workflow/status/shiftingphotons/moodytags/Spec"/></br>
</p>

## Features
- Authenticate and fetch playlists with Spotify
- Create collection of tags for easier use
- Tag playlists
- Basic dashboard showing your tagged playlists

## Roadmap
- Ability to tag albums and songs
- Integration with another streaming service
  
  
## How To Use
### Run It Locally
While the hosted version can be found [here](https://moodytags.shiftingphotons.dev), moodytags can be run locally.  

#### Prerequisites
Spotify is the only integration for now, so you must be user of the platform. For the integration to work, you also must have a developer application on [their platform](https://developer.spotify.com/dashboard/).  

While creating an application, you'll be asked for a scope. A recommended application scope for now is:  
```
user-library-read playlist-read-collaborative playlist-read-private
```  

The final requirement is to place your Spotify client id and client secret in `.env.spotify` file at the root of the project so they can be read on application start.
```
SPOTIFY_CLIENT_ID=YOUR_CLIENT_ID
SPOTIFY_CLIENT_SECRET=YOUR_CLIENT_SECRET
```


### Setup

Running the whole application is done through [docker-compose](https://docs.docker.com/compose/).  
```
docker-compose up
```
Setup the development database.
```
docker-compose exec api bundle exec hanami db prepare
```
Everything should be working. By default the application should be found on [localhost](http://localhost)

### Running the tests

First prepare the testing database:
```
docker-compose exec -e HANAMI_ENV=test api bundle exec hanami db prepare
```
Run the tests:
```
docker-compose exec api bundle exec rake spec
```
