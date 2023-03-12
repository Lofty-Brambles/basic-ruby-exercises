# frozen_string_literal: true

require_relative 'tree'

# driver script
array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)

puts '---- The tree ----'
tree.pretty_print

puts '---- Is it balanced? ----'
tree.balanced?

puts '---- level_order ----'
tree.level_order

puts '---- preorder traversal ----'
tree.preorder

puts '---- inorder traversal ----'
tree.inorder

puts '---- postorder traversal ----'
tree.postorder

puts '---- inserting a number ----'
tree.insert(rand(1..100))
