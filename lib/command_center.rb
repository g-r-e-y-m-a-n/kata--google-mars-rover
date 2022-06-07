#!/usr/bin/env ruby
# coding:utf-8
# frozen_string_literal: true

require_relative "../helpers/nasa_helpers"
require_relative "mars_rover"

module NASA
  class CommandCenter
    include NASA::Helpers

    def initialize(plateau_coordinates, rover_parameters)
      error("Invalid CommandCenter Parameters", {
        plateau_coordinates: plateau_coordinates,
        rover_parameters: rover_parameters
      }) unless valid(plateau_coordinates, rover_parameters)

      @plateau_coordinates = plateau_coordinates
      @rover_parameters = rover_parameters
    end

    def deploy
      @result = []

      @rover_parameters.each do |rover|
        deployed_rover = MarsRover.new(@plateau_coordinates, rover[0], rover[1])
        @result << deployed_rover.get_coordinates
      end

      @result
    end
  end
end