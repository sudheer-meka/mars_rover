require_relative "martian_rover"
require_relative "controller"
require_relative "command"
require_relative "plateau"

Command.register 'L', :turn_left
Command.register 'R', :turn_right
Command.register 'M', :move

class Processor
  def initialize(command_text)
    @lines = command_text.split("\n")
  end

  def process
    set_plateau
    send_commands_to_rovers
  end

  def set_plateau
    first_line = @lines.shift
    width, height = first_line.split(' ').map(&:to_i)
    @plateau = Plateau.new width, height
  end

  def send_commands_to_rovers
    result = ''

    @lines.each_slice(2) do |position, commands|
      x_coordinate, y_coordinate, direction_side = position.split(' ')
      initial_location = Position::Location.new(x_coordinate.to_i, y_coordinate.to_i, @plateau)
      side_index = Position::SIDE_REPRESENTATION.index(direction_side)
      side = Position::SIDES[side_index]

      initial_direction = Position::Direction.new side
      martian_rover = MartianRover.new(initial_location, initial_direction)
      controller = Controller.new rover: martian_rover
      controller.send_commands commands
      result << "#{martian_rover.report}\n"
    end
    result
  end
end