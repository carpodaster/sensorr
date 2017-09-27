require "sensorr/version"
require "sensorr/factory"
require "thread"

module Sensorr
  @sources = []
  @_mtx = Mutex.new

  class << self
    def sources
      @_mtx.synchronize do
        @sources ||= []
      end
    end

    def push(source)
      @_mtx.synchronize do
        @sources.push source
      end
    end
    alias add push
    alias << push

    def pop
      @_mtx.synchronize do
        @sources.pop source
      end
    end
  end
end
