require_relative "position"

module Position

  # Direction part of the position
  #   side represents the real direction
  # @see Position::SIDES
  class Direction
    attr_reader :side

    def initialize(side)
      SIDES.include? side or raise RuntimeError, 'Direction is not valid'
      @side = side
    end

    def rotate_left
      left_side = SIDES.index(@side) - 1
      @side = SIDES[left_side % 4]
    end

    def rotate_right
      right_side = SIDES.index(@side) + 1
      @side = SIDES[right_side % 4]
    end

    def represented_side
      side_index = SIDES.index(@side)
      SIDE_REPRESENTATION[side_index]
    end

  end
end
