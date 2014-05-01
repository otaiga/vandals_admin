require 'httparty'
require 'open-uri'

class FacebookFeed
  
  def get_feed
    results = HTTParty.get(base_url).parsed_response
    formatted_data(results)  
  end

  def formatted_data(results)
    return unless results['data']
    results['data'].each do |record|
      Post.where(record_atts(record)).first_or_create! do |post|
        post.attributes = record_atts(record)
      end
      #perform second call
      if record['object_id'] && Post.find_by object_id: record['object_id']
        post = Post.find_by object_id: record['object_id']
        fb_large_picture_url = get_large_photo(record['object_id'])
        post.update_column(:large_image_url, fb_large_picture_url)
      end
    end
  end

   def get_large_photo(object_id)
    second_uri = URI('https://graph.facebook.com/#{object_id}/?picture')
    second_results = HTTParty.get(second_uri).parsed_response
    formatted_picture_data(second_results)
   end

  def formatted_picture_data(second_results)
    second_results['source']
  end

  private

  def base_url
    "https://graph.facebook.com/#{vandals_id}/posts/?#{fb_access_token}"
  end

  def base_token_url
    "https://graph.facebook.com/oauth/access_token?"
  end

  def vandals_id
    ENV['VANDALS_FB_ID']
  end

  def client_id
    ENV['APP_ID']
  end

  def client_secret
    ENV['APP_SECRET']
  end

  def fb_access_token
    required_args = [
      "client_id=#{client_id}",
      "client_secret=#{client_secret}",
      "grant_type=client_credentials"
    ].join('&')
    url = token_url + required_args
    token_response = HTTParty.get(url)
  end

  def record_atts(record)
    return unless record
    {
      message: record['message'],
      picture: record['picture'],
      link: record['link'],
      object_id: record['object_id'],
      description: record['description'],
      created_time: record['created_time']
    }
  end

end
