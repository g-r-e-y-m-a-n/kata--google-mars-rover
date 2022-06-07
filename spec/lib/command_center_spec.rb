require "spec_helper"
require_relative "../../lib/command_center"

RSpec.describe NASA::CommandCenter do
  let(:test) { {
    input: ["5 5", [["1 2 N", "LMLMLMLMM"], ["3 3 E", "MMRMMRMRRM"]]],
    output: ["1 3 N", "5 1 E"]
  } }

  let(:valid_command_center) { described_class.new(test[:input][0], test[:input][1]) }
  let(:invalid_command_center_1) { described_class.new(test[:input][0], nil) }
  let(:invalid_command_center_2) { described_class.new(nil, test[:input][1]) }
  let(:invalid_command_center_3) { described_class.new(nil, nil) }

  describe "#initialize" do
    context "with valid parameters" do
      it "initializes successfully" do
        expect(valid_command_center).to be_truthy
      end

      it "successfully runs calculation of coordinates" do
        expect(valid_command_center.deploy).to eq(test[:output])
      end
    end

    context "with invalid parameters" do
      it "fails gracefully" do
        expect{ invalid_command_center_1 }.to raise_exception("MarsRover Error -> Invalid CommandCenter Parameters (plateau_coordinates: '#{test[:input][0]}', rover_parameters: '')")
        expect{ invalid_command_center_2 }.to raise_exception("MarsRover Error -> Invalid CommandCenter Parameters (plateau_coordinates: '', rover_parameters: '#{test[:input][1]}')")
        expect{ invalid_command_center_3 }.to raise_exception("MarsRover Error -> Invalid CommandCenter Parameters (plateau_coordinates: '', rover_parameters: '')")
      end
    end
  end
end