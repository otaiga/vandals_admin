require 'httparty'
require 'open-uri'
require 'json'

class FacebookFeed
  #Constants
  VANDALS_ID = ENV['VANDALS_FB_ID']
  FB_ACCESS_TOKEN = ENV['FACEBOOK_ACCESS_TOKEN']
  CLIENT_ID = ENV['APP_ID']
  CLIENT_SECRET = ENV['APP_SECRET']
  
def get_feed
  fb_access_token = access_token
  uri = URI(URI.escape "https://graph.facebook.com/#{VANDALS_ID}/posts/?#{fb_access_token}")
  response = HTTParty.get(uri)
  results = JSON.parse(response.body)
  formatted_data(results)  
end

def access_token
  token_uri = URI("https://graph.facebook.com/oauth/access_token?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&grant_type=client_credentials")
  token_response = HTTParty.get(token_uri)
end


def formatted_data(results)
    if results['data']
        for record in results['data'] do
             attrs = {
                 message: record['message'],
                 picture: record['picture'],
                 link: record['link'],
                 object_id: record['object_id'],
                 description: record['description'],
                 created_time: record['created_time']
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
        
        #Delete Posts that have no message (unavailable pages on facebook)
        delete_if_nil = Post.where(message: nil) 
        delete_if_nil.destroy_all
          
    end
 end

 def get_large_photo(object_id)
     second_uri = URI("https://graph.facebook.com/#{object_id}/?picture")
     second_response = HTTParty.get(second_uri)
     second_results = JSON.parse(second_response)
     formatted_picture_data(second_results)
 end

 def formatted_picture_data(second_results)
  second_results['source']
 end

end