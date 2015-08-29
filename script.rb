require 'twitter'
require 'csv'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "YOUR_CONSUMER_KEY"
  config.consumer_secret     = "YOUR_CONSUMER_SECRET"
  config.access_token        = "YOUR_ACCESS_TOKEN"
  config.access_token_secret = "YOUR_ACCESS_SECRET"
end

follower_ids = client.follower_ids('aarontveit') # or replace with the Twitter handle you're interested in tracking
begin
  follower_ids.to_a
rescue Twitter::Error::TooManyRequests => error
  # NOTE: Your process could go to sleep for up to 15 minutes but if you
  # retry any sooner, it will almost certainly fail with the same exception.
  sleep error.rate_limit.reset_in + 1
  retry
end

time = Time.now.getutc

CSV.open("path/to/output.csv", "a") do |csv|
  csv << [follower_ids.to_a.size, time]
end