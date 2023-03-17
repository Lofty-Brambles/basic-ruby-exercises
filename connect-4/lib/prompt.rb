# frozen_string_literal: true

require_relative 'interface'

# acts as a DI indulgent method of prompting
class Prompt
  include Interface

  def initialize(input = STDIN, output = STDOUT)
    @input = input
    @output = output
  end

  def ask(text, invalid_text = nil)
    @output.print prettify_question(text)
    loop do
      input = @input.gets.chomp
      return input if !block_given? || yield(input)
      @output.print prettify_question(invalid_text)
    end
  end
end
