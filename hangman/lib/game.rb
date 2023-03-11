require_relative 'interface'
require 'yaml'

# the main game logic
class Game
  include Interface

  def initialize(data = {})
    @key = data['key'] || generate_key
    @clue = data['clue'] || Array.new(@key.length, '_').join
    @guesses = data['guesses'] || []
    @guesses_left = data['guesses_left'] || 10
    @save = false
  end

  def prompt_move
    show_status
    move_on = false
    guess_prompt = "Enter a letter to guess or type 'save' to save the game."
    ans = prompt(guess_prompt).downcase
    process_move(ans, guess_prompt)
  end

  def over?
    if @key == @clue
      show_result("You guessed the word correctly! It was #{@key}", true)
      return true
    elsif @guesses_left == 0
      show_result("You couldn't guess the word! It was #{@key}", false)
      return true
    elsif @save == true
      save_it
      show_result("The game was saved!", true)
      return true
    end

    false
  end

  private

  def generate_key
    text_file = 'google-10000-english-no-swears.txt'
    file = File.open(File.join(Dir.pwd, text_file), 'r')
    words = file.readlines
    words[-1] = words[-1] + "\n"
    file.close

    word = words.sample[0..-2]
    until word.length >= 5 && word.length <= 12
      word = words.sample[0..-2]
    end
    word
  end

  def show_status
    msg = "Number of incorrect guesses remaining: #{@guesses_left}"

    puts @guesses_left <= 3 ? "#{RED}#{msg}#{RESET}" : msg
    puts "Letters guessed: #{@guesses.join(" ")}"
    puts "#{GREEN}#{@clue}#{RESET}"
  end

  def process_move(input, guess_prompt)
    begin
      criterion = @guesses.include?("#{GREEN}#{input}#{RESET}") || \
                  @guesses.include?("#{RED}#{input}#{RESET}")

      if input == 'save'
        @save = true
        return
      end

      raise "Invalid input" unless input =~ /^[[:alpha:]]$/
      raise "Repeated input" if criterion
      try_guess(input)
    rescue StandardError => exception
      puts "#{RED}#{exception.to_s}#{RESET}"
      ans = prompt(guess_prompt).downcase
      process_move(ans, guess_prompt)
    end
  end

  def try_guess(guess)
    if @key.include?(guess)
      @guesses.push("#{GREEN}#{guess}#{RESET}")
      @key.split('').each_with_index { |c, i| @clue[i] = c if c == guess }
      puts "#{GREEN}That is in the word!#{RESET}"
    else
      @guesses.push("#{RED}#{guess}#{RESET}")
      @guesses_left -= 1
      puts "#{GREEN}That letter is not in the word!#{RESET}"
    end
  end

  def save_it
    file_name_regex = /games\/(\w+)\.yaml/
    file_name = Dir.glob('games/*').map { |file| file.match(file_name_regex)[1] }

    message = "Enter a name for saving the game as"
    ans = prompt(message).downcase
    while file_name.include?(ans)
      ans = prompt("There is already the name of another game. #{message}").downcase
    end

    data = YAML.dump({
      'key' => @key,
      'clue' => @clue,
      'guesses' => @guesses,
      'guesses_left' => @guesses_left
    })

    File.open(File.join(Dir.pwd, "/games/#{ans}.yaml"), 'w') { |f| f.write(data) }
  end
end