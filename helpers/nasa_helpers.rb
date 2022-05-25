module NASA
  module Helpers
    def valid(plateau_coordinates, rover_parameters)
      return false unless plateau_coordinates.is_a?(String) && plateau_coordinates.match(/^\d+? \d+?$/)
      return false unless rover_parameters.is_a?(Array)

      rover_parameters.each do |rover_param|
        return false unless rover_param.is_a?(Array)
        return false unless rover_param[0].is_a?(String) && rover_param[0].match(/^\d+? \d+? [NEWS]$/)
        return false unless rover_param[1].is_a?(String) && rover_param[1].match(/^[LRM]+?$/)
      end

      true
    end

    def error(message = "", data = {})
      error_message = "MarsRover Error -> #{message}"

      error_message << " ("
      data.each_with_index do |(k, v), i|
        error_message << "#{k}: '#{v}'"
        error_message << ", " unless i == data.size - 1
      end
      error_message << ")"

      @exception = Exception.new(error_message.chomp)
      raise @exception
    end
  end
end
