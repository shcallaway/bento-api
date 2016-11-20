source 'https://rubygems.org'

# For uploading files to S3.
gem 'carrierwave', '0.10.0'
gem "fog"

# For hiding special things.
gem 'dotenv-rails'

# MySQL for the DB.
gem 'mysql2'

# Rails, of course.
gem 'rails', '5.0.0.1'

# Use Puma as the app server.
gem 'puma', '3.0'

# For handling CORS.
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere to stop execution and get a debugger console.
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Keeps the app running in the background. (Helpful for development.) See: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem.
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
