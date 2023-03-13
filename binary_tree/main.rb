# frozen_string_literal: true

require_relative 'tree'

# driver script
array = Array.new(10) { rand(1..100) }
p array.sort.uniq
tree = Tree.new(array)

puts '---- The tree ----'
tree.pretty_print

puts '---- Is it balanced? ----'
p tree.balanced?

puts '---- level_order ----'
p tree.level_order

puts '---- preorder traversal ----'
p tree.preorder

puts '---- inorder traversal ----'
p tree.inorder

puts '---- postorder traversal ----'
p tree.postorder

puts '---- inserting a number ----'
3.times { tree.insert(rand(1..100)) }
tree.pretty_print

puts '---- is balanced? ----'
p tree.balanced?

puts '---- rebalance ----'
tree.rebalance
tree.pretty_print
