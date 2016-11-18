# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Include the resource name in JSON.
ActiveRecord::Base.include_root_in_json = true