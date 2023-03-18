# frozen_string_literal: true

require_relative 'interface'
require_relative 'check_win'

# the main board to play for connect4
class Board
  include Interface

  attr_reader :turn, :board
  attr_writer :result

  def initialize(prompter, player1, player2)
    @input = prompter
    @player1 = { name: player1, symbol: RED_CIRCLE }
    @player2 = { name: player2, symbol: BLUE_CIRCLE }

    @PLAYER_NUM = { true => 1, false => 2 }
    @PLAYER_DTLS = { true => @player1, false => @player2 }

    @board = Array.new(7) { Array.new(6, BLANK_CIRCLE) }
    @turn = false
    @results = { status: 'undeclared' }
  end

  def play
    while @results[:status] == 'undeclared'
      revert_turn
      reshow_board
      update_board(prompt)
      @results = CheckWin.new(@board, @PLAYER_DTLS, @turn).evaluate
    end
    declare_winner
  end

  def revert_turn
    @turn = !@turn
  end

  def reshow_board
    render_text
    print_board
  end

  def prompt
    msg = "Player #{@PLAYER_NUM[@turn]} (#{@PLAYER_DTLS[@turn][:name]}) | Enter column number to move"
    @input.ask(msg, "Invalid, must be between 1 and 7. #{msg}") { |i| verify_column(i) }
  end
  
  def update_board(ans)
    sign = @PLAYER_DTLS[@turn][:symbol]
    array = @board[ans.to_i - 1]
    array[array.index(BLANK_CIRCLE)] = sign
  end

  def declare_winner
    if @results[:status] == 'draw'
      show_result('It is a draw!', false)
    elsif @results[:status] == 'over'
      show_result("Player #{@PLAYER_NUM[@turn]} (#{@PLAYER_DTLS[@turn][:name]}) has won!", true)
    end
  end

  private

  def print_board
    display_board(@board, @player1, @player2)
  end

  def verify_column(word)
    /^[1-7]$/.match?(word)
  end
end