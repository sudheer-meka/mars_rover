require_relative "position/direction"
require_relative "position/location"

# A rover; it has a direction and location
#   and can move or turn
class MartianRover

  def initialize(location, direction)
    @location = location
    @direction = direction
  end

  def turn_left
    @direction.rotate_left
  end

  def turn_right
    @direction.rotate_right
  end

  def move
    side = @direction.side
    side_coordinates = @location.coordinates_of side
    @location.change_coordinates_to *side_coordinates
  end

  # reports its last position
  def report
    "#{@location.x_coordinate} #{@location.y_coordinate} #{@direction.represented_side}"
  end

end