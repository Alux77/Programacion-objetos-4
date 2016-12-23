require 'nokogiri'
require 'open-uri'

url = 'https://twitter.com/CH14_'

class TwitterScrapper

  def initialize(url)
    @url = url
    @url = Nokogiri::HTML(open(url))
  end

  def extract_username

  profile_name = @url.search(".ProfileHeaderCard-name > a")
  profile_name.first.inner_text

  puts "Username: #{profile_name.first.inner_text}"
  puts "----------------------------------------------------------------------------"

  end
  
  def extract_tweets
    puts "Tweets:"
    tweets = @url.search(".tweet")
    tweets.map do |tweet|
      tweet_text = tweet.css(".content .tweet-text").inner_text
      tweet_time = tweet.css(".content .tweet-timestamp ._timestamp").inner_text
      tweet_retweets = tweet.css(".content .ProfileTweet-action--retweet .ProfileTweet-actionCountForPresentation").inner_text
      tweets_likes = tweet.css(".content .ProfileTweet-action--favorite .ProfileTweet-actionCount .ProfileTweet-actionCountForPresentation").inner_text
      
      
      puts "#{tweet_time}: #{tweet_text}"
      puts "Retweets:#{tweet_retweets[0..2]}, Favorites:#{tweets_likes[0..2]}"
    end
  end

  def extract_stats
    stats = @url.search(".ProfileNav-value")
    stats.map do |stat|
      stat.inner_text
    end
    puts "Stats: Tweets: #{stats[0].inner_text}, Siguiendo: #{stats[1].inner_text}, Seguidores: #{stats[2].inner_text}, Favoritos: #{stats[3].inner_text}"
    puts "----------------------------------------------------------------------------"
  end

end

url = TwitterScrapper.new('https://twitter.com/CH14_')

url.extract_username
url.extract_stats
url.extract_tweets