# frozen_string_literal: true

require_relative 'interface'
require_relative 'game_logic'
require_relative 'ai'

# the loop in which the game continues
class GameLoop
  include Interface
  include GameLogic

  attr_reader :play_again

  def initialize(player_type, guesses)
    @player_type = player_type
    @guesses = guesses
    results = computer_play if player_type == 1
    results = human_play if player_type == 2
    @play_again = display_results(results)
  end

  private

  def human_play
    render_text "The AI has decided the code and now, you have to break it!"
    code = Array.new(4).map { Random.new.rand(1..6) }.join
    for turn in (1..@guesses)
      return true if prompt_user_turn(turn, code)
    end
    show_result("The code was #{code.split('').map { |s| piece(s.to_i) }.join(' ')}", false)
    false
  end

  def computer_play
    render_text
    msg = "enter a 4 digit code that has digits between 0 and 6"
    code = prompt(msg.capitalize)
    unless code =~ /^[1-6]{4}$/
      code = prompt("Wrong Input. Please #{msg}")
    end
    AIPlay.new(code, @guesses).play()
  end

  def display_results(results)
    if results
      case @player_type
      when 1 then show_result('The computer has successfuly cracked the code!', true)
      when 2 then show_result('You were able to crack the code!', true)
      end
    else
      case @player_type
      when 1 then show_result('The computer was unable to crack the code!', false)
      when 2 then show_result('You were unable to crack the code!', false)
      end
    end

    play_again = prompt('Would you like to play again? [y|n]')
    play_again.match?(/(y|ye|yes)/i)
  end
end