# frozen_string_literal: true

require_relative 'interface'
require_relative 'board'

# The main class to communicate with the interface
class GameApi
  include Interface

  def initialize
    play_again = true
    while play_again == true
      play_again = false
      init_game
      play_again = game_loop
    end
  end

  private

  def init_game
    render_text("\nWelcome! Please enter the following details to start:")
    dtls = run_input_wizard
    @player1 = dtls[0][:player]
    @player2 = dtls[1][:player]
    @board = Board.new(dtls[0][:symbol], dtls[1][:symbol])
  end

  def run_input_wizard
    dtls = []

    error_msg = 'The symbol should be a single character and not a number.'
    dtls.push(input_parse(1, /^[^0-9]$/, error_msg))
    error_msg = "The symbol should be a single character and not a number or #{dtls[0][:symbol]}"
    dtls.push(input_parse(2, /^[^0-9#{dtls[0][:symbol]}]$/, error_msg))
    dtls
  end

  def input_parse(num, pattern, error_msg)
    name = prompt("Player #{num} | Enter name")
    symbol = prompt("Player #{num} | Enter symbol")
    until symbol.match(pattern)
      show_error(error_msg)
      symbol = prompt("Player #{num} | Enter symbol")
    end
    { player: name, symbol: symbol }
  end

  def game_loop
    results = { status: 'continue' }
    show_board(@board, @player1, @player2)
    while results[:status] == 'continue'
      move = fetch_move.to_i - 1
      results = @board.play_move(move / 3, move % 3)
      show_board(@board, @player1, @player2)
    end
    display_results(results)
  end

  def fetch_move
    pattern = /^[#{@board.possible_move_indices}]$/
    move = prompt("Player #{@board.turn_for_player1 ? 1 : 2}: Please choose a position")
    until move.match(pattern)
      moves = @board.possible_move_indices.split('').join(', ')
      show_error("The move should be one of the numbers: #{moves}")
      move = prompt("Player #{@board.turn_for_player1 ? 1 : 2}: Please choose a position")
    end
    move
  end

  def display_results(results)
    if [true, false].include?(results[:result])
      show_result("Player #{results[:result] ? 1 : 2} has won, rejoice!")
    else
      show_result('It is a DRAW!')
    end

    play_again = prompt('Would you like to play again? [y|n]')
    play_again.match?(/(y|ye|yes)/i)
  end
end

GameApi.new
