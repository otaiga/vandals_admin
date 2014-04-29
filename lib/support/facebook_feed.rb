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
  #puts results
  puts formatted_data(results)
  
end

def formatted_data(results)
  # Return only if there are results
	return unless results

  results['data'].map { |m| 
  attrs = { message: m['message'], 
            picture: m['picture'], 
            link: m['link'], 
            object_id: m['object_id']
          }

  Post.where(attrs).first_or_create! do |post|
    post.attributes = attrs
  end
  }
end






end
