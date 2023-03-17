# frozen_string_literal: true

require_relative 'interface'

# the main board to play for connect4
class Board
  include Interface

  PLAYER_NUM = { true => 1, false => 2 }
  PLAYER_DTLS = { true => @player1, false => @player2 }

  attr_reader :turn, :board

  def initialize(prompter, player1, player2)
    @input = prompter
    @player1 = { name: player1, symbol: RED_CIRCLE }
    @player2 = { name: player2, symbol: BLUE_CIRCLE }
    @board = Array.new(7) { Array.new(6) }
    @turn = true
    @results = { status: 'undeclared' }
  end

  def play
    while @results[:status] == 'undeclared'
      revert_turn
      reshow_board
      update_board(prompt_move)
      check_win
    end
    declare_winner
  end

  def revert_turn
    @turn = !@turn
  end

  def reshow_board
    render_text
    display_board
  end

  def prompt
    msg = "Player #{PLAYER_NUM[@turn]} (#{PLAYER_DTLS[@turn][:name]}) | Enter column number to move"
    @input.ask(msg, "Invalid, must be between 1 and 7. #{msg}") { |i| verify_column(i) }
  end
  
  def update_board(ans)
    @board[ans.to_i - 1].push(PLAYER_DTLS[@turn][:symbol])
  end

  private

  def print_board
    display_board(@board, @player1, @player2)
  end
end