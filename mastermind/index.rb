# frozen_string_literal: true

require_relative 'interface'
require_relative 'game_loop'

# the main game interface
class GameAPI
  include Interface

  def initialize
    replay = true
    while replay == true
      replay = init_game
    end
  end

  private

  def init_game
    render_text(header("\nHow to play mastermind:\n\n"))
    instructions
    player_type = get_player_type
    guesses = get_number_of_guesses
    loops = GameLoop.new(player_type.to_i, guesses.to_i)
    loops.play_again
  end

  def instructions
    puts "You play against an AI, as a #{header('code-maker')} or a #{header('code-breaker')}."
    puts "There are #{header('6 numbers')}, which form a #{header('4 digit code')}.\n\n"
    puts "\r#{(1..6).map { |n| piece(n) }.join(' ')}\n\n"
    puts "There can even be #{header('more than one')} of the same digits."
    puts "To win, the code-breaker needs to guess it within a certain number of guess."
    puts "\n#{header('Clues:')}\nAfter each guess, there will be upto four clues to crack it."
    puts "\r#{clue_piece("*")} Indicates that you have 1 correct number, in the correct place."
    puts "\r#{clue_piece("?")} Indicates that you have 1 correct number, in the incorrect place.\n\n"
    puts "#{header('Lets start playing!')}\nWould you like to play as a code BREAKER or a code MAKER?"
  end

  def get_player_type
    msg = "Select [1] to play as a MAKER, or [2] to play as a BREAKER"
    reply = prompt(msg)
    unless reply =~ /^[12]$/
      reply = prompt("Incorrect option. #{msg}")
    end
    reply
  end

  def get_number_of_guesses
    msg = "Enter the number of guesses the code BREAKER will have:"
    reply = prompt(msg)
    unless reply =~ /^[1-9]+[0-9]*$/
      reply = prompt("Incorrect, it needs to be a number. #{msg}")
    end
    reply
  end
end

GameAPI.new
