# frozen_string_literal: true

require_relative 'list'
require_relative 'node'

def pp(message)
  puts "\n\x1b[32;01m#{message}\x1b[39;49;00m"
end

list = LinkedList.new
pp '---=--- Starting the list! ---=---'

pp '1. Appending 1, 2 and 3'
list.append(1)
list.append(2)
list.append(3)

pp '2. Returning the first element:'
p list.head

pp '3. Returning the last element: '
p list.tail

pp '4. Prepending a 4'
list.prepend(4)

pp '5. Printing the size: '
p list.size

pp '6. Checking if the list contains first a 5, then a 3.'
begin
  p list.contains?(5)
  p list.contains?(3)
rescue StandardError => e
  p e
end

pp '6. Checking if the list finds first a 2, then a 5.'
begin
  p list.find(2)
  p list.find(5)
rescue StandardError => e
  p e
end

pp '7. Popping out the last element in the list: '
puts list.pop

pp '8. Checking if some element at index 5, exists'
begin
  p list.at(5)
rescue StandardError => e
  p e
end

pp '9. Pretty prints.'
p list.to_s
