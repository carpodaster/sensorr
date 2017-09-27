# frozen_string_literal: true
require 'thor'

module Sensorr
  class CLI < Thor

    desc "check [<sensor_pair>, …]", ""
    def check(*sensor_pairs)
      if sensor_pairs.empty?
        Sensorr.update!.each do |source|
          puts source.name + ":"
          source.channels.each do |channel|
            puts "  #{channel}"
          end
        end
      else
        exit 1
      end
    end
  end
end
