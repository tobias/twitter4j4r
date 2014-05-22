require 'jar/twitter4j-core-3.0.5.jar'
require 'jar/twitter4j-stream-3.0.5.jar'
require 'jar/twitter4j-async-3.0.5.jar'

require 'twitter4j4r/listener'
require 'twitter4j4r/config'

module Twitter4j4r
  class Client
    def initialize(config)
      unless config.is_a? Config
        auth_map                    = config
        config                      = Twitter4j4r::Config.new
        config.consumer_key         = auth_map[:consumer_key]
        config.consumer_secret      = auth_map[:consumer_secret]
        config.access_token         = auth_map[:access_token]
        config.access_token_secret  = auth_map[:access_secret]
      end

      build = config.build
      @stream = Java::Twitter4j::TwitterStreamFactory.new(build).instance
      @twitter = Java::Twitter4j::TwitterFactory.new(build).instance
    end

    def on_exception(&block)
      @exception_block = block
      self
    end

    def on_limitation(&block)
      @limitation_block = block
      self
    end

    def on_deletion(&block)
      @deletion_block = block
      self
    end

    def on_status(&block)
      @status_block = block
      self
    end

    def follow(twitter_ids, &block)
      add_listener(&block)
      @stream.filter(Java::Twitter4j::FilterQuery.new(0, twitter_ids.to_java(:long), nil))
    end

    def track(*search_terms, &block)
      add_listener(&block)
      @stream.filter(Java::Twitter4j::FilterQuery.new(0, nil, search_terms.to_java(:string)))
    end

    def filter(twitter_ids, *search_terms, &block)
      add_listener(&block)
      @stream.filter(Java::Twitter4j::FilterQuery.new(0,
                     twitter_ids.to_java(:long),
                     search_terms.to_java(:string)))
    end

    def lookup_users(user_names)
      @twitter.lookup_users(user_names.to_java(:string))
    end

    def sample(&block)
      add_listener(&block)
      @stream.sample
    end

    def add_listener(&block)
      on_status(&block)
      @stream.addListener(Listener.new(self, @status_block, @exception_block, @limitation_block, @deletion_block))
    end

    def stop
      @stream.cleanUp
      @stream.shutdown
    end
  end
end
