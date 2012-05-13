require 'open-uri'
require 'json'

class HpageController < ApplicationController
  def fetch_tweets(name)
    result = []
    i = 1
    tweets = JSON.parse(open("http://api.twitter.com/1/statuses/user_timeline.json?screen_name=#{name}&count=100&page=#{i}&include_rts=1&trim_user=true&include_entities=false&callback=?").read)  
    begin 
      result << tweets
      i += 1
      tweets = JSON.parse(open("http://api.twitter.com/1/statuses/user_timeline.json?screen_name=#{name}&count=100&page=#{i}&include_rts=1&trim_user=true&include_entities=false&callback=?").read)  
    end while !tweets.empty?
    result.flatten!
    return result
  end

      
  
  def index
  end
  
  def show
    @user = params[:username]
    tweets = fetch_tweets(@user)
    all_words = []
    tweets.each do |tweet|
      all_words << tweet["text"].split(' ')
    end
    all_words.flatten!
    @unique_words = {}
    all_words.each do |word|
      if @unique_words[word]
        @unique_words[word] += 1
      else
        @unique_words[word] = 1
      end
    end      
    @max = 0
    @unique_words.each do |word, count|
      if count > @max
        @max = count
      end
    end
    
  end
end