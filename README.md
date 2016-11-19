## Creating a Track

The request for creating a track should look like this:

URL: http://localhost:3000/v1/tracks 

Method: POST 

Headers: 

Authorization | Token token=10f251790e0d2d5d7a12f93b5caedd10

Body: form-data

track[name]   | Sexy Back               | text
track[artist] | Justin Timberlake       | text
track[title]  | FutureSex/LoveSounds    | text
track[file]   |                         | file

## Environment Variables

Your .env file should include:

Ask the lead developer for one of these.

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY

Get these from S3.

* AWS_S3_BUCKET_DEV
* AWS_S3_BUCKET_TEST
* AWS_S3_BUCKET_PROD
* AWS_REGION

Generate this with: RAILS_ENV=production rake secret

* PROD_SECRET_KEY_BASE

## Authentication

The API uses simple token-based authentication to prevent consumers from abusing the endpoints. It's easy to generate an api key -- just send a POST request to the /api_keys route. The keys expire after a short period of time. To disable authentication for development purposes, comment-out this line from tracks_controller.rb:

before_action :restrict_access

This line calls the restrict_access method, which checks for a valid token.

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