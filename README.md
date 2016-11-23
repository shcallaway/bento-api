## Getting Started
### Dependencies

Make sure you have these things:
* Git
* Ruby (v2.3.1 or higher)
* Rails (v5.0.0.1 or higher)

### Contributing

Clone the repository, switch into the new directory, and install the necessary gems:
```
$ git clone https://github.com/shcallaway/bento-api.git
$ cd bento-api
$ bundle install
```

Before you start coding, check out a new branch with the name of your feature. To create a new branch:
```
$ git checkout -b feature_name
```
Commit early and often. Submit a pull request when you're done.

To run the app, you'll have to create the database, run the DB migrations, and start the server:
```
$ rake db:create
$ rake db:migrate
$ rails server
```

## Authentication

The API uses simple token-based authentication to prevent consumers from abusing the endpoints. It's easy to generate an api key -- just send a POST request to the /api_keys route. The keys expire after a short period of time. To disable authentication for a given controller (for development purposes), comment out this line:

```
before_action :restrict_access
```

This line calls the restrict_access method, which checks for a valid token.

## Create a Track

The API's most complicated route is easily 'create a track'. This particular route underpins the upload feature, which allows users to expand the Bento catalog by uploading audio files and providing metadata. 

In order to preserve the integrity of the database, `create a track` must accomodate for scenarios in which the associated artist and/or release already exists within the catalog, as well as scenarios in which one or both of these entities is missing.

Currently, the `create a track` route includes the logic for associating new tracks with existing artists and releases, as well as creating new tracks and releases if necessary. 

Here's an example of a POST /v1/tracks request, made with Postman:

URL: http://localhost:3000/v1/tracks 

Method: POST 

Headers: 

| Key            | Value                                        |
| -------------- | -------------------------------------------- |
| Authorization  | Token token=10f251790e0d2d5d7a12f93b5caedd10 |

Body: form-data

| Key            | Value                | Type          |
| -------------- | -------------------- | ------------- |
| track[name]    | Sexy Back            | text          |
| track[artist]  | Justin Timberlake    | text          |
| track[release] | FutureSex/LoveSounds | text          |
| track[file]    | (Choose a file.)     | file          |

## Environment Variables

Your .env file should include:

(Ask the lead developer for these.)

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY

(Get these from AWS S3.)

* AWS_S3_BUCKET_DEV
* AWS_S3_BUCKET_TEST
* AWS_S3_BUCKET_PROD
* AWS_REGION

(Run the following command:)

```
$ RAILS_ENV=production rake secret
```

* PROD_SECRET_KEY_BASE

## Response Format

Below are example responses from each of the routes.

### GET /v1/tracks

```
{
  [
    {
      "id": "1",
      "name": "Sexy Back",
      "artist": {
        "id": "1",
        "name": "Justin Timberlake"
      },
      "release": {
        "id": 1,
        "name": "FutureSex/LoveSounds"
      },
      "file": "https://bento-development.s3.amazonaws.com/uploads/sexy-back_justin-timberlake_futuresex/lovesounds"
    }
  ]
}
```

### GET /v1/tracks/1

```
{
  "id": "1",
  "name": "Sexy Back",
  "artist": {
    "id": "1",
    "name": "Justin Timberlake"
  },
  "release": {
    "id": 1,
    "name": "FutureSex/LoveSounds"
  },
  "file": "https://bento-development.s3.amazonaws.com/uploads/sexy-back_justin-timberlake_futuresex/lovesounds"
}
```

### GET /v1/artists

```
{
  [
    {
      "id": "1",
      "name": "Justin Timberlake",
      "releases": [
        {
          "id": 1,
          "name": "FutureSex/LoveSounds"
        }
      ]
    }
  ]
} 
```

### GET /v1/artists/1

```
{
  "id": "1",
  "name": "Justin Timberlake",
  "releases": [
    {
      "id": 1,
      "name": "FutureSex/LoveSounds"
    }
  ]
}
```

### GET /v1/releases

```
[
  {
    "id": 2,
    "name": "FutureSex/LoveSounds",
    "artist": {
      "id": 2,
      "name": "Justin Timberlake"
    }
  }
]
```

### GET /v1/releases/1

```
{
  "id": 2,
  "name": "FutureSex/LoveSounds",
  "artist": {
    "id": 2,
    "name": "Justin Timberlake"
  }
}
```

### POST /api_keys

```
{
  "api_key": {
    "id": 1,
    "token": "f078b7be5f2c0932d2219cadecdd751b",
    "created_at": "2016-11-20T20:03:45.000Z",
    "updated_at": "2016-11-20T20:03:45.000Z",
    "expiry": "2016-11-23T20:03:45.000Z"
  }
}
```

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
