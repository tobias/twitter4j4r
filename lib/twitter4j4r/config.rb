require 'jar/twitter4j-core-3.0.5.jar'

module Twitter4j4r
  class Config
    def initialize
      @config = Java::Twitter4jConf::ConfigurationBuilder.new
      @config.setDebugEnabled true
    end

    def consumer_key= consumer_key
      @config.setOAuthConsumerKey consumer_key
    end

    def consumer_secret= consumer_secret
      @config.setOAuthConsumerSecret consumer_secret
    end

    def access_token= access_token
      @config.setOAuthAccessToken access_token
    end

    def access_token_secret= access_token_secret  
      @config.setOAuthAccessTokenSecret access_token_secret
    end

    def username= username
      @config.setUser username
    end

    def password= password
      @config.setPassword password
    end

    def build
      @config.build
    end
  end
end
