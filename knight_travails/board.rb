# frozen_string_literal: true

require_relative 'square'

# queue that acts as a mode of traversing the board
class Board
  def initialize(start)
    @start = Square.new(nil, start)
    init_process_vars
  end

  def find_level(finish)
    square = @start
    until square.position == finish
      square.generate_moves.each { |move| @queue.push(move) }
      square = @queue.shift
    end

    init_process_vars
    generate_result_path(square)
  end

  private

  def init_process_vars
    @history = []
    Square.reinitialize
    @queue = [Square.new(nil, @start)]
  end

  def generate_result_path(square)
    generate_result_path(square.parent) unless square.parent.nil?
    p square.position
  end
end
