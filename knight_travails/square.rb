# frozen_string_literal: true

# square that acts as the component of a route
class Square
  attr_accessor :parent, :position, :children

  SHIFTS = [[1, 2], [2, 1], [-1, 2], [2, -1], [-1, -2], [-2, -1], [1, -2], [-2, 1]].freeze

  # rubocop:disable Style/ClassVars

  @@history = []

  # rubocop:enable Style/ClassVars

  def initialize(parent, position)
    @parent = parent
    @position = position
    @@history.push(position)
  end

  def generate_moves
    create_all_moves
      .select { |post| valid_move?(post) && !@@history.include?(post) }
      .map { |move| Square.new(self, move) }
  end

  def self.reinitialize
    # rubocop:disable Style/ClassVars

    @@history = []

    # rubocop:enable Style/ClassVars
  end

  private

  def create_all_moves
    SHIFTS.map { |shift| [@position[0] + shift[0], @position[1] + shift[1]] }
  end

  def valid_move?(position)
    position[0].between?(1, 8) && position[1].between?(1, 8)
  end
end
