# frozen_string_literal: true

require_relative 'board'

def knight_travails(start, finish)
  tree = Board.new(start)
  tree.find_level(finish)
end

puts 'knight_travails([3,3],[4,3]) =>'
knight_travails([3, 3], [4, 3])
