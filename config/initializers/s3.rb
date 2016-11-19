CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_REGION'] 
  }

  if Rails.env.development?
    config.fog_directory = ENV['AWS_S3_BUCKET_DEV']
  elsif Rails.env.test?
    config.fog_directory = ENV['AWS_S3_BUCKET_TEST']
  elsif Rails.env.production?
    config.fog_directory = ENV['AWS_S3_BUCKET_PROD']
  end 
end