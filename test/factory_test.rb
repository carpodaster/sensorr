require 'test_helper'

describe "Sensorr::Factory" do

  describe '.from_raw_sensors_output' do
    let(:sensors_output) { File.read(File.expand_path("../fixtures/sensors-u.out", __FILE__)) }

    subject do
      Sensorr::Factory.from_raw_sensors_output(sensors_output)
    end

    it "returns a list of classes responding whose name corresponds to sensor categories" do
      subject.map(&:name)
        .must_equal ["temp1", "temp2", "Physical id 0", "Core 0", "Core 1", "Core 2", "Core 3"]
    end
  end

end
