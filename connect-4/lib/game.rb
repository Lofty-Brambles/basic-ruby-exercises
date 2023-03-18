# frozen_string_literal: true

require_relative 'interface'
require_relative 'prompt'
require_relative 'board'

# the base class for a loop for the game
class Game
  include Interface

  def initialize
    @input = Prompt.new
  end

  def play_loop
    replay_loop = true
    while replay_loop == true
      play_game
      replay_loop = play_again?
    end
  end

  def play_game
    render_text(bolden("To start the game, enter the following details:"))
    player1 = @input.ask("Player 1 | Enter name")
    player2 = @input.ask("Player 2 | Enter name")
    Board.new(@input, player1, player2).play
  end

  def play_again?
    @input.ask('Would you like to play again? [y|n]').match?(/(y|ye|yes)/i)
  end
end
