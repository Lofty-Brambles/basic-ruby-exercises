# frozen_string_literal: true

require_relative 'interface'
require_relative 'game'
require 'yaml'

# main interface
class API
  include Interface

  def initialize
    restart = true
    while restart == true
      render_text("Guess the word in 12 or less guesses!")
      restart = game_loop
    end
  end

  private

  def game_loop
    message = "Would you like to [1] Start a new game or [2] Load a new game?"
    choice = prompt(message)
    until ['1', '2'].include?(choice)
      choice = prompt("Invalid input. #{message}")
    end

    game = choice == '1' ? Game.new : Game.new(load_game)
    game.prompt_move until game.over?

    play_again = prompt('Would you like to play again? [y|n]')
    play_again.match?(/(y|ye|yes)/i)
  end

  def load_game
    file = get_game
    data = {}
    File.open(File.join(Dir.pwd, file), 'r') { |f| data = YAML.load(f) }
    data
  end

  def get_game
    print "These are the files that are saved:\n\n"

    file_name_regex = /games\/(\w+)\.yaml/
    file_name = Dir.glob('games/*').map { |file| file.match(file_name_regex)[1] }
    file_name.each_with_index { |name, index| puts "[ #{index + 1} ] #{name}" }
    
    message = "Please choose which game you would like to save"
    selected = prompt(message).downcase
    until file_name.include?(selected)
      selected = prompt("#{selected} does not exist. #{message}").downcase
    end
    "/games/#{selected}.yaml"
  end
end

API.new