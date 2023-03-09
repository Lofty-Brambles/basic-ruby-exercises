# frozen_string_literal: true

require_relative 'interface'

# main root level game logic, common to both types of programs
module GameLogic
  include Interface

  def prompt_user_turn(turn, code)
    msg = 'enter four numbers (1-6) to guess the code'
    reply = prompt("Turn ##{turn}/#{@guesses}: #{msg.capitalize}")
    unless reply =~ /^[1-6]{4}$/
      reply = prompt("Wrong Input. Please #{msg}")
    end
    evaluate_move(reply, code)
  end

  def prompt_computer(message, turn, code)
    computer_prompt(message, turn)
    computer_evaluate_move(turn, code)
  end

  def raw_evaluate_move(turn, code)
    { exact: exact_places(turn, code), match: match_places(turn, code) }
  end

  private

  def evaluate_move(move, code)
    print "\r#{move.split('').map { |num| piece(num.to_i) }.join(' ')}"
    exact = exact_places(move, code)
    print "  Clues: #{Array.new(exact).map { clue_piece('*') }.join(' ')}" \
          " #{Array.new(match_places(move, code)).map { clue_piece('?') }.join(' ')}\n\n"
    exact == 4
  end

  def computer_evaluate_move(move, code)
    print "\r#{move.split('').map { |num| piece(num.to_i) }.join(' ')}"
    exact = exact_places(move, code)
    match = match_places(move, code)
    print "  Clues: #{Array.new(exact).map { clue_piece('*') }.join(' ')}" \
          " #{Array.new(match).map { clue_piece('?') }.join(' ')}\n\n"
    { exact: exact, match: match }
  end

  def exact_places(move, code)
    exact = 0
    code.split('').each_with_index do |i, index|
      exact += 1 if i == move.split('')[index]
    end
    exact
  end

  def match_places(move, code)
    match = 0
    move.split('').each_with_index do |i, index|
      check = i != code.split('')[index] && code.split('').include?(i)
      match += 1 if check
    end
    match
  end
end