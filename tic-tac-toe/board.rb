# frozen_string_literal: true

# the main game environments
class Board
  attr_reader :symbols, :turn_for_player1

  def initialize(player1, player2)
    @array = Array.new(3) { Array.new(3, nil) }
    @symbols = [player1, player2]
    @turn_for_player1 = true
  end

  def play_move(row, col)
    p @turn_for_player1
    p @turn_for_player_1 ? 1 : 0
    p self
    @array[row][col] = @symbols[@turn_for_player_1 ? 1 : 0]

    results = fetch_results(row, col)
    return results if results[:status] == 'yields'

    @turn_for_player1 = !@turn_for_player1
  end

  def display_proof_board
    @array.map.with_index do |row, index|
      row.map.with_index do |element, second_index|
        element.nil? ? index * 3 + second_index + 1 : element
      end
    end
  end

  def possible_move_indices
    indices = []
    @array.each_with_index do |row, index|
      row.each_with_index do |element, second_index|
        indices << (index * 3 + second_index + 1) if element.nil?
      end
    end
    indices.join
  end

  private

  def fetch_results(row_pos, col_pos)
    return { status: 'yields', result: 'draw' } if check_for_draw

    win = check_for_row_sum(row_pos, col_pos).any? { |num| num == 3 }
    return { status: 'yields', result: @turn_for_player_1 } if win

    { status: 'continue' }
  end

  def check_for_row_sum(row_pos, col_pos)
    col = row = pdiag = ndiag = 0
    3.times do |i|
      col += 1 if @array[i][col_pos]
      row += 1 if @array[row_pos][i]
      pdiag += 1 if @array[i][i]
      ndiag += 1 if @array[2 - i][i]
    end

    [col, row, pdiag, ndiag]
  end

  def check_for_draw
    @array.flat_map { |e| e }.none?(&:nil?)
  end
end
