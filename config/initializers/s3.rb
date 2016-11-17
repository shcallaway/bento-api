CarrierWave.configure do |config|

  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'], # replace with ENV[''] before committing
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # replace with ENV[''] before committing
    region: ENV['AWS_REGION'] 
  }

  config.fog_directory = ENV['AWS_S3_BUCKET'] # bucket name

end