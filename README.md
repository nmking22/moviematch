<!-- Shields -->
![](https://img.shields.io/badge/Rails-6.1.1-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-orange)

# Plenty of Flicks BE

![plenty_of_flicks_logo](https://user-images.githubusercontent.com/68172332/116182397-753d5580-a6d9-11eb-8392-15235cc6feb0.png)

## Table of Contents
  - [What it does](#what-it-does)
  - [How to Install](#how-to-install)
  - [Dependencies](#dependencies)
  - [Learning Goals](#learning-goals)
  - [Project Diagram](#project-diagram)
  - [Schema](#schema)
  - [API Documentation](#api-documentation)
  - [Licenses](#licenses)
  - [Contact](#contact)
  
## What it does

### The Plenty of Flicks App

> We all know the struggle. You sit down to watch a movie with a group of friends or significant other, and spend more time picking out a suitable flick than actually watching the movie. Enter Plenty of Flicks. Users can explore available movies on three supported subscription services (Netflix, Amazon Prime Video and Hulu), and add movies to their watchlist. When it's time to watch, users create a party with the group they want to watch with, and voila: PoF presents a list of movies they ALL want to watch.

### The Plenty of Flicks BE Repo

> The Plenty of Flicks BE Repo leverages two external APIs to create custom endpoints for the FE Repo. The Watchmode API (https://api.watchmode.com/docs/) '/list-titles' endpoint is used to collect and refresh information about available movies on supported services, while The Movie Database API (https://developers.themoviedb.org/3/getting-started/introduction) is used to get detailed information about the available movies including images, descriptions and ratings. The data is stored in the BE PostgreSQL database, and uses a combination of RESTful and non-RESTful endpoints to pass the data to the FE.
> Please [visit the Plenty of Flicks FE Repo here](https://github.com/plenty-of-flicks/plenty_of_flicks_fe).

## How to Install

For usage on your local machine follow the instructions listed below:

> 1. git clone git@github.com:plenty-of-flicks/plenty_of_flicks_be.git
> 1. cd plenty_of_flicks_be
> 1. bundle
> 1. rake db:{create,migrate,seed}
> 1. bundle exec figaro install
> 1. Add watchmode and tmdb api keys to the config/application.yml file (Available at https://api.watchmode.com/ and https://developers.themoviedb.org/3/getting-started/introduction respectively)
```
  # in config/application.yml
    WATCHMODE_API_KEY: <your watchmode api key>
    TMDB_API_KEY: <your tmdb api key>
 ```
> 7. rails s
> 8. Visit localhost:3000 in your web browser

## Dependencies

* This app uses Rails version `6.1.3.1`

* The [Figaro](https://github.com/laserlemon/figaro) gem is used to keep confidential information like API keys secure.

* The [Fast JSON API](https://github.com/Netflix/fast_jsonapi) gem is used to serialize data.

* The [SimpleCov](https://github.com/simplecov-ruby/simplecov) gem is used to ensure that 100% of our code is covered with unit testing.

* The [Webmock](https://github.com/bblimke/webmock) and [VCR](https://github.com/vcr/vcr) gems are used for mocking and stubbing BE API calls.


## Learning Goals

  * Gain experience working on a solo full-stack application
  
  * Understand and implement background workers
  
  * Refactor code for better code for improved organization/readability

  * Write thorough and understandable documentation

## Project Diagram


## Schema

<img width="1177" alt="Screen Shot 2021-05-10 at 5 03 40 PM" src="https://user-images.githubusercontent.com/68172332/117734951-c35e5880-b1b1-11eb-99c9-2f47477bcfb0.png">

## API Documentation

### POST /api/v1/swipes

POST /api/v1/swipes creates a swipe entry in the BE database. The swipes table is a joins table between users and movies that signifies a user either adding a movie to their watchlist or removing it as a possibility to be swiped in the future.

#### Request Parameters

|     Name        |      Type     |   Description                                                                                               |
| --------------- | ------------- | ----------------------------------------------------------------------------------------------------------- |
|  user_id        |  Integer      |   (required) - the id of the user that is swiping on a movie                                                |
|  movie_id       |  Integer      |   (required) - the id of the movie that the user is swiping on                                              |
|  rating         |  Integer      |   (required) - must be 0 (negative swipe) or 1 (positive swipe) - superswipe (2) planned in future iteration|

#### Sample Response

```
{
  "data": {
    "id":"63",
    "type":"swipe",
    "attributes": {
      "id":63,
      "user_id":91,
      "movie_id":809,
      "rating":1
    }
  }
}
```

### POST /api/v1/users

POST /api/v1/users creates a user entry in the BE database.

#### Request Parameters

|     Name        |      Type     |   Description                                                                                               |
| --------------- | ------------- | ----------------------------------------------------------------------------------------------------------- |
|  uid            |  Integer      |   (required) - the uid for the user's google account                                                        |
|  email          |  String       |   (required) - the email associated with the account.                                                       |
|  first_name     |  String       |   (required) - the user's first name                                                                        |
|  last_name      |  String       |   (required) - the user's last name                                                                         |
|  image.         |  String       |   (required) - the path for the user's avatar                                                               |

#### Sample Response

```
{
  "data": {
    "id":"92",
    "type":"user",
    "attributes": {
      "first_name":"John",
      "last_name":"Doe",
      "email":"johndoe@gmail.com",
      "uid":"12345678910",
      "image":"https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg"
    }
  }
}
```

### PATCH /api/v1/users/:uid

PATCH /api/v1/users updates a user entry in the BE database.

#### Request Parameters

|     Name        |      Type     |   Description                                                                                               |
| --------------- | ------------- | ----------------------------------------------------------------------------------------------------------- |
|  email          |  String       |   (optional) - the email associated with the account.                                                       |
|  first_name     |  String       |   (optional) - the user's first name                                                                        |
|  last_name      |  String       |   (optional) - the user's last name                                                                         |
|  image.         |  String       |   (optional) - the path for the user's avatar                                                               |

#### Sample Response

```
{
  "data": {
    "id":"92",
    "type":"user",
    "attributes": {
      "first_name":"John",
      "last_name":"Doe",
      "email":"johndoe@gmail.com",
      "uid":"12345678910",
      "image":"https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg"
    }
  }
}
```

### GET /api/v1/movies/random_available

GET /api/v1/movies/random_available returns the attributes of a random movie that is currently available on one of the supported services, and that the given user has not yet created a swipe for

#### Request Parameters

|     Name        |      Type     |   Description                                                                                               |
| --------------- | ------------- | ----------------------------------------------------------------------------------------------------------- |
|  user_id        |  Integer      |   (required) - the user id for the current user.                                                            |

#### Sample Response

```
{
  "data": {
    "id":"857",
    "type":"movie",
    "attributes": {
      "title":"Austin Powers: International Man of Mystery",
      "tmdb_id":816,
      "poster_path":"/5uD4dxNX8JKFjWKYMHyOsqhi5pN.jpg",
      "description":"As a swingin' fashion photographer by day and a groovy British superagent by night, Austin Powers is the '60s' most shagadelic spy, baby! But can he stop megalomaniac Dr. Evil after the bald villain freezes himself and unthaws in the '90s? With the help of sexy sidekick Vanessa Kensington, he just might.",
      "genres": [
        {
          "id":87,
          "name":"Action",
          "created_at":"2021-04-27T05:22:49.498Z",
          "updated_at":"2021-04-27T05:22:49.498Z",
          "tmdb_id":1
        },
        {
          "id":88,
          "name":"Comedy",
          "created_at":"2021-04-27T05:22:49.499Z",
          "updated_at":"2021-04-27T05:22:49.499Z",
          "tmdb_id":2
        }
      ],
      "vote_average":6.5,
      "vote_count":2357,
      "year":"1997"
    }
  }
}
```

### GET /api/v1/services/update_availability

GET /api/v1/services/update_availability - clears the BE movie availabilities table (joins table between services and movies that signifies which movies are available on each service) of all entries of the given service, then repopulates the table with the service's current availabilties as per the Watchmode API. This method, though inefficient, was chosen due to endpoint limitations of the Watchmode API. Background workers are used here, as the endpoint can take a long time to process.

#### Request Parameters

|     Name        |      Type     |   Description                                                                                               |
| --------------- | ------------- | ----------------------------------------------------------------------------------------------------------- |
|  service        |  String       |   (required) - the name of the service to be updated (netflix, hulu, or amazon)                             |

#### Sample Response

```
{
  "data": {
    "id":null,
    "type":"service_refresh",
    "attributes": {
      "name":"Hulu",
      "movie_count":2010
    }
  }
}
```

### GET /api/v1/movies/populate_details

GET /api/v1/movies/populate_details - searches through the movies table for entries with missing information. For each such movie, the BE makes an API call to TMDB API to fetch the movie's details, then updates the database's movie entry with the fetched data. Background workers are used here, as the endpoint can take a long time to process.

#### Sample Response

```
{
  "movies_updated":3,
  "update_status":"Complete - incomplete movies have been populated."
}
```

## Licenses

  * Ruby 2.5.3
  * Rails 6.1.3.1

## Contact

<h4>Nick King</h4>
<img src="https://avatars.githubusercontent.com/u/68172332?s=460&u=8b0b3766e31ff6be0d1dea0a8591483dc1bdd870&v=4" alt="Nick King"
 width="150" height="auto" style="float: left" />

[GitHub Profile](https://github.com/nmking22)
