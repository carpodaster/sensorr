require "sensorr/version"
require "sensorr/cli"
require "sensorr/factory"
require "thread"

module Sensorr
  @sources = []
  @_mtx = Mutex.new

  SENSORS_BIN="/usr/bin/sensors"

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

    def update!
      @_mtx.synchronize do
        @sources = Sensorr::Factory.from_raw_sensors_output(`#{SENSORS_BIN} -u`)
      end
    end
  end

end
