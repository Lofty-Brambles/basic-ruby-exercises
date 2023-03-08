# frozen_string_literal: true

def char_processor(char, shift)
  minimum_shift = shift % 26
  minimum_shift.times { char = char.succ } if ('a'...'z').include?(char.downcase)
  char[-1]
end

def caesar_cipher(string, shift)
  puts string.split('').map { |c| char_processor(c, shift) }.join
end

caesar_cipher('What a string!', 5)
# => "Bmfy f xywnsl!"
