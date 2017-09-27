# frozen_string_literal: true
require 'thor'

module Sensorr
  class CLI < Thor

    desc "check [<sensor_pair>, …]", "Returns sensor data for the selected Source:sensor combinations"
    long_desc <<-DESC
    Returns sensor data for the selected Source:sensor combinations. Returns all available
    sensor values when no further arguments are supplied.

    Example:

    $ sensorr check "Core 0:temp2_input" "Core 0:temp2_crit"
    DESC
    def check(*sensor_pairs)
      Sensorr.update!
      if sensor_pairs.empty?
        Sensorr.sources.each do |source|
          puts source.name + ":"
          source.channels.each do |channel|
            puts "  #{channel}"
          end
        end
      else
        sensor_pairs.each do |pair|
          source_name, channel_name = pair.split(':')
          if source = Sensorr.sources.detect{|s| s.name == source_name}
            if channel = source.channels.detect{|c| c.name == channel_name}
              puts "#{source.name.inspect}.#{channel.name.inspect}: #{channel.value}"
            end
          end
        end
      end
    end
  end
end
