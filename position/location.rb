require_relative "position"

module Position

  # Location part of the position
  #   x and y coordinates represents the real location
  #   uses Position::SIDES to find near coordinates
  # @see Position::SIDES
  class Location
    attr_reader :x_coordinate, :y_coordinate

    def initialize(x_coordinate, y_coordinate, plateau)
      @plateau = plateau
      change_coordinates_to(x_coordinate, y_coordinate)
    end

    def change_coordinates_to(x_coordinate, y_coordinate)
      unless [x_coordinate, y_coordinate].all? { |coordinate| coordinate.is_a? Numeric }
        raise RuntimeError, 'Position is not valid'
      end
      if x_coordinate.between? 0, @plateau.width and y_coordinate.between? 0, @plateau.height
        @x_coordinate = x_coordinate
        @y_coordinate = y_coordinate
      else
        raise RuntimeError, 'Location must be within the plateau borders'
      end
    end

    def north_coordinates
      [@x_coordinate, @y_coordinate+1]
    end

    def east_coordinates
      [@x_coordinate+1, @y_coordinate]
    end

    def west_coordinates
      [@x_coordinate-1, @y_coordinate]
    end

    def south_coordinates
      [@x_coordinate, @y_coordinate-1]
    end

    def coordinates_of(side)
      SIDES.include? side or raise RuntimeError, 'Side is not valid'
      send "#{side}_coordinates"
    end
  end
end