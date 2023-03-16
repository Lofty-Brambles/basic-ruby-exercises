# frozen_string_literal: true

require_relative 'interface'

# the main board to play for connect4
class Board
  include Interface

  # [x] simply initializes the board variables
  def initialize(player1, player2)
    @player1 = { name: player1, symbol: RED_CIRCLE }
    @player2 = { name: player2, symbol: BLUE_CIRCLE }
    @board = Array.new(7) { Array.new(6, BLANK_CIRCLE) }
    @turn_for_player1 = true
  end

  private

  # [x] public puts method
  def print_board
    display_board(@board, @player1, @player2)
  end
end