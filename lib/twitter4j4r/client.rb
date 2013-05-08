require 'jar/twitter4j-core-2.2.6.jar'
require 'jar/twitter4j-stream-2.2.6.jar'
require 'jar/twitter4j-async-2.2.6.jar'

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

      @stream = Java::Twitter4j::TwitterStreamFactory.new(config.build).instanceend
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
      add_listener(&block)
      @stream.filter(Java::Twitter4j::FilterQuery.new(0, nil, search_terms.to_java(:string)))
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
