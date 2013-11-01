ActiveAdmin::Editor.configure do |config|
    config.s3_bucket = ENV['S3_BUCKET_NAME']
    config.aws_access_key_id = ENV['AWSAccessKeyId']
    config.aws_access_secret = ENV['AWSSecretKey']
    config.storage_dir = 'app/public/user-content/'
end
