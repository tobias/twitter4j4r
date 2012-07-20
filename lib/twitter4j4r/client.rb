require 'jar/twitter4j-core-2.2.6.jar'
require 'jar/twitter4j-stream-2.2.6.jar'
require 'twitter4j4r/listener'

module Twitter4j4r
  class Client
    def initialize(auth_map)
      @stream = Java::Twitter4j::TwitterStreamFactory.new(config(auth_map)).instance
    end

    def on_exception(&block)
      @exception_block = block
      self
    end

    def on_limitation(&block)
      @limitation_block = block
      self
    end

    def on_status(&block)
      @status_block = block
      self
    end

    def track(*terms, &block)
      on_status(&block)
      start(terms)
    end
    
    def start(search_terms)
      @stream.addListener(Listener.new(self, @status_block, @exception_block, @limitation_block))
      @stream.filter(Java::Twitter4j::FilterQuery.new(0, nil, search_terms.to_java(:string)))
    end

    def stop
      @stream.cleanUp
      @stream.shutdown
    end

    protected
    
    def config(auth_map)
      config = Java::Twitter4jConf::ConfigurationBuilder.new
      config.setDebugEnabled(true)
      config.setOAuthConsumerKey(auth_map[:consumer_key])
      config.setOAuthConsumerSecret(auth_map[:consumer_secret])
      config.setOAuthAccessToken(auth_map[:access_token])
      config.setOAuthAccessTokenSecret(auth_map[:access_secret])
      config.build
    end

  end
end
