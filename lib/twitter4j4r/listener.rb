require 'jar/twitter4j-stream-3.0.5.jar'
require 'jruby/core_ext'

module Twitter4j4r
    class Listener
    include Java::Twitter4j::StatusListener

    def initialize(client, status_block, exception_block, limitation_block, deletion_block)
      @client = client
      @status_block = status_block
      @exception_block = exception_block
      @limitation_block = limitation_block
      @deletion_block = deletion_block
    end
    
    def onStatus(status)
      call_block_with_client(@status_block, status)
    end

    def onException(exception)
      call_block_with_client(@exception_block, exception)
    end

    def onTrackLimitationNotice(limited_count)
      call_block_with_client(@limitation_block, limited_count)
    end

    def onDeletionNotice(deletion_notice)
      call_block_with_client(@deletion_block, deletion_notice)
    end

    protected
    def call_block_with_client(block, *args)
      block.call(*((args + [@client])[0, block.arity])) if block
    end
  end
end

Twitter4j4r::Listener.become_java!
