module NASA
  class MarsRoverException < Exception
    @message = nil

    def initialize(msg = nil)
      parse_message(msg)
      msg = @message.chomp

      super
    end

    private

    def parse_message(message = "", data = {})
      @message = "MarsRover Exception -> #{message}"

      @message << " ("
      data.each_with_index do |(k, v), i|
        @message << "#{k}: '#{v}'"
        @message << ", " unless i == data.size - 1
      end
      @message << ")"
    end
  end
end
