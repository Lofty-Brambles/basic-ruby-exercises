# frozen_string_literal: true

require_relative 'interface'

# the base class for a loop for the game
class Game
  include Interface

  # [] test
  def initialize
    replay_loop = true
    while replay_loop == true
      play_game
      replay_loop = play_again?
    end
  end

  # [x] puts and gets functions, with a public script method
  def play_game
    render_text(bold("To start the game, enter the following details:"))
    player1 = prompt("Player 1 | Enter name")
    player2 = prompt("Player 2 | Enter name")
    Board.new(player1, player2)
  end

  # [x] simple gets function that checks if it's yes or something else
  def play_again?
    prompt('Would you like to play again? [y|n]').match?(/(y|ye|yes)/i)
  end
end
