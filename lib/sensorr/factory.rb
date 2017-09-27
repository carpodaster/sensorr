# frozen_string_literal: true
module Sensorr
  class Factory
    Source = Class.new do
      attr_reader :name, :channels
      def initialize(name)
        @name = name
        @channels = []
      end
    end

    Channel = Struct.new(:name, :value) do
      def to_s
        name + ": " + value
      end
    end

    class << self
      def from_raw_sensors_output(sensors_output)
        sources = []
        lines = sensors_output.split(/\n/).reject(&:empty?)
        lines.map.with_index do |line, ix|
          if line =~ /\A(\S.+?):?\z/
            if lines[ix+1][0..1] == '  '
              sources << Source.new($1)
            end
          else
            chan_values = line.split(': ').map(&:strip)
            sources.last.channels << Channel.new(*chan_values)
          end
        end
        sources
      end
    end
  end
end
