# frozen_string_literal: true

require_relative 'interface'

class CheckWin
  include Interface

  def initialize(board, players, turn)
    @board = board
    @symbol = players[turn][:symbol]
  end
  
  def evaluate
    return { status: 'draw' } if is_draw?
    is_win? ? { status: 'over' } : { status: 'undeclared' }
  end

  def is_win?
    check_in_col(@board) || check_in_row || check_in_diagonals || check_in_anti_diagonals
  end

  def is_draw?
    !@board.flatten.include?(BLANK_CIRCLE)
  end

  private

  def check_in_col(board)
    board.reduce(false) do |acc, col|
      acc = acc || col.each_cons(4).any? { |set| set.all?(@symbol) }
    end
  end

  def check_in_row
    check_in_col(@board.transpose)
  end

  def generate_diagonals
    right = (1..3).map { |i| (0..6 - i).map { |j| @board[i + j][j] } }
    left = (0..2).map { |i| (0..5 - i).map { |j| @board[j][i + j] } }
    right + left
  end

  def check_in_diagonals
    check_in_col(generate_diagonals)
  end

  def generate_anti_diagonals
    right = (-3..-1).map { |i| (-6..i).map { |j| @board[j.abs + i][j] } }
    left = (1..3).map { |i| (1..6 - i).map { |j| @board[i + j - 1][-j] } }
    right + left
  end

  def check_in_anti_diagonals
    check_in_col(generate_anti_diagonals)
  end
end