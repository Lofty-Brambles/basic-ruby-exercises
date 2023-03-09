# frozen_string_literal: true

require_relative 'game_logic'

# the logic w/ which the computer plays
class AIPlay
  include GameLogic

  def initialize(code, guesses)
    @code = code
    @guesses = guesses
  end

  def play
    move_set = [*(1..6)].repeated_permutation(4).to_a
    first_iter = true
    guess_count = 0

    while @guesses >= guess_count
      guess = move_set[0]
      if first_iter
        guess = [1, 1, 2, 2]
        first_iter = false
      end
      move_set.delete(guess)

      guess_count += 1
      message = computer_message(guess_count, @guesses)
      prompt = prompt_computer(message, guess.join, @code)
      exact, match = prompt.values_at(:exact, :match)
      return true if exact == 4

      move_set.length.times do |i|
        element = move_set.shift
        exact2, match2 = raw_evaluate_move(guess.join, element.join).values_at(:exact, :match)
        move_set.push(element) if exact == exact2 && match == match2
      end
    end

    false
  end

  private

  def computer_message(num, total)
    "Computer turn number #{num}/#{total}"
  end
end
