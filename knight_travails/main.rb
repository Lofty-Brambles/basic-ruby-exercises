# frozen_string_literal: true

require_relative 'tree'

def knight_travails(start, finish)
  tree = Tree.new(start)
  tree.find_level(finish)
end

puts 'knight_travails([3,3],[4,3]) =>'
p knight_travails([3,3],[4,3])
