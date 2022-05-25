require "spec_helper"
require_relative "../../lib/mars_rover"

RSpec.describe NASA::MarsRover do
  let(:test) { {
    input: ["5 5", "1 2 N", "LMLMLMLMM"],
    output: "1 3 N"
  } }

  let(:valid_rover) { described_class.new(test[:input][0], test[:input][1], test[:input][2]) }
  let(:invalid_movement_params) { "LRMMY" }
  let(:invalid_rover_1) { described_class.new(test[:input][0], nil, nil) }
  let(:invalid_rover_2) { described_class.new(nil, test[:input][1], nil) }
  let(:invalid_rover_3) { described_class.new(nil, nil, test[:input][2]) }
  let(:invalid_rover_4) { described_class.new(nil, nil, nil) }
  let(:invalid_rover_5) { described_class.new(test[:input][0], test[:input][1], invalid_movement_params) }

  describe "#initialize" do
    context "with valid parameters" do
      it "initializes successfully" do
        expect(valid_rover).to be_truthy
      end
    end

    context "with invalid parameters" do
      it "fails gracefully" do
        expect{ invalid_rover_1 }.to raise_exception("MarsRover Error -> Invalid Rover Parameters (plateau_coordinates: '#{test[:input][0]}', starting_coordinates: '', move_commands: '')")
        expect{ invalid_rover_2 }.to raise_exception("MarsRover Error -> Invalid Rover Parameters (plateau_coordinates: '', starting_coordinates: '#{test[:input][1]}', move_commands: '')")
        expect{ invalid_rover_3 }.to raise_exception("MarsRover Error -> Invalid Rover Parameters (plateau_coordinates: '', starting_coordinates: '', move_commands: '#{test[:input][2]}')")
        expect{ invalid_rover_4 }.to raise_exception("MarsRover Error -> Invalid Rover Parameters (plateau_coordinates: '', starting_coordinates: '', move_commands: '')")
        expect{ invalid_rover_5 }.to raise_exception("MarsRover Error -> Invalid Rover Parameters (plateau_coordinates: '#{test[:input][0]}', starting_coordinates: '#{test[:input][1]}', move_commands: '#{invalid_movement_params}')")
      end
    end
  end

  describe "#start" do
    context "valid move commands" do
      it "moves successfully" do
        expect(valid_rover.get_coordinates).to eq(test[:output])
      end
    end
  end

  describe "#get_coordinates" do
    it "returns the correct coordinate format" do
      expect(valid_rover.get_coordinates).to match(/^(\d \d [A-Z])$/)
    end
  end

  describe "#move" do
    context "with valid movement parameters" do
      it "moves successfully" do
        expect(valid_rover.move).to be_truthy
      end
    end

    context "with invalid movement parameters" do
      it "fails gracefully" do
        expect{ valid_rover.move("X") }.to raise_exception("MarsRover Error -> Invalid Rover Orientation (orientation: 'X')")
      end
    end
  end

  describe "#turn" do
    context "with valid directions" do
      it "turns successfully" do
        expect(valid_rover.turn("L")).to eq("W")
        expect(valid_rover.turn("R")).to eq("N")
        expect(valid_rover.turn("R")).to eq("E")
      end
    end

    context "with invalid directions" do
      it "fails gracefully" do
        expect{ valid_rover.turn("X") }.to raise_exception("MarsRover Error -> Invalid Turning Direction (direction: 'X')")
      end
    end
  end
end