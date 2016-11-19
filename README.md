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