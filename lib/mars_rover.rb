#!/usr/bin/env ruby
# coding:utf-8
# frozen_string_literal: true

require_relative "../helpers/nasa_helpers"

module NASA
  class MarsRover
    include NASA::Helpers

    def initialize(plateau_coordinates, starting_coordinates, move_commands)
      error("Invalid Rover Parameters", {
        plateau_coordinates: plateau_coordinates,
        starting_coordinates: starting_coordinates,
        move_commands: move_commands
      }) unless valid(plateau_coordinates, [[starting_coordinates, move_commands]])

      @parameters = {
        plateau_coordinates: plateau_coordinates,
        plateau_width: plateau_coordinates[0].to_i,
        plateau_height: plateau_coordinates[2].to_i,
        move_commands: move_commands,
        rover_position_x: starting_coordinates[0].to_i,
        rover_position_y: starting_coordinates[2].to_i,
        rover_orientation: starting_coordinates[4]
      }

      start
    end

    def start
      @parameters[:move_commands].each_char do |c|
        error("Invalid Move Command '#{c}'") unless c.match(/[LRM]/)

        if c == "M"
          move(@parameters[:rover_orientation])
        else
          turn(c)
        end
      end
    end

    def get_coordinates
      coordinates = "#{@parameters[:rover_position_x]} #{@parameters[:rover_position_y]} #{@parameters[:rover_orientation]}"

      puts coordinates

      coordinates
    end

    def move(orientation = nil)
      orientation = @parameters[:rover_orientation] if orientation.nil?

      case orientation
        when "N"
          @parameters[:rover_position_y] += 1
        when "E"
          @parameters[:rover_position_x] += 1
        when "W"
          @parameters[:rover_position_x] -= 1
        when "S"
          @parameters[:rover_position_y] -= 1
      else
        error("Invalid Rover Orientation", {
          orientation: orientation
        })
      end
    end

    def turn(direction)
      error("Invalid Turning Direction", {
        direction: direction
      }) unless direction == "L" || direction == "R"

      case @parameters[:rover_orientation]
        when "N"
          @parameters[:rover_orientation] = "W" if direction == "L"
          @parameters[:rover_orientation] = "E" if direction == "R"
        when "E"
          @parameters[:rover_orientation] = "N" if direction == "L"
          @parameters[:rover_orientation] = "S" if direction == "R"
        when "W"
          @parameters[:rover_orientation] = "S" if direction == "L"
          @parameters[:rover_orientation] = "N" if direction == "R"
        when "S"
          @parameters[:rover_orientation] = "E" if direction == "L"
          @parameters[:rover_orientation] = "W" if direction == "R"
      else
        error("Invalid Rover Orientation", @parameters)
      end

      @parameters[:rover_orientation]
    end
  end
end