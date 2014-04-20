# Using as a central place to store aws setup
module S3ImageConfig
  def s3_credentials
    {
      bucket: ENV['AWS_BUCKET'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
  end

  def s3_headers
    {
      'Cache-Control' => 'max-age=315576000',
      'Expires' => 1.year.from_now.httpdate
    }
  end
end
