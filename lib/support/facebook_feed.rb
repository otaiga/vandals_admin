require 'httparty'
require 'open-uri'
require 'json'

class FacebookFeed
  #Constants
  VANDALS_ID = ENV['VANDALS_FB_ID']
  FB_ACCESS_TOKEN = ENV['FACEBOOK_ACCESS_TOKEN']
  FACEBOOK_URL = "https://graph.facebook.com/#{VANDALS_ID}/posts/?access_token=#{FB_ACCESS_TOKEN}"
  
def get_feed
  uri = URI(FACEBOOK_URL)
  response = HTTParty.get(uri)
  results = JSON.parse(response.body)
  return formatted_data(results)  
end

def formatted_data(results)
    if results['data']
        for record in results['data'] do
             attrs = {
                 message: record['message'],
                 picture: record['picture'],
                 link: record['link'],
                 object_id: record['object_id']
             }

             Post.where(attrs).first_or_create! do |post|
              post.attributes = attrs
             end

             #perform second call
             if record['object_id']
                post = Post.find_by object_id: record['object_id']
                if post
                    fb_large_picture_url = get_large_photo(record['object_id'])
                    post.update_column(:large_image_url, fb_large_picture_url)
                end
             end
        end
    end
 end

 def get_large_photo(object_id)
     second_uri = URI("https://graph.facebook.com/#{object_id}/?picture")
     second_response = HTTParty.get(second_uri)
     second_results = JSON.parse(second_response)
     return formatted_picture_data(second_results)
 end

 def formatted_picture_data(second_results)
  return second_results['source']
 end

end