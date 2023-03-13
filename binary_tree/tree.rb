# frozen_string_literal: true

require_relative 'node'
require_relative 'tree_helper'

# the main tree class
class Tree
  include TreeHelper

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    array = array.sort.uniq
    recur_tree(array, 0, array.length - 1)
  end

  def insert(value)
    find_and_insert(@root, value)
  end

  def delete(value)
    find_and_delete(nil, @root, value)
  end

  def find(value, node = @root)
    case node <=> value
    when -1
      find(value, node.right)
    when 1
      find(value, node.left)
    else
      node
    end
  end

  def level_order(&block)
    results = []
    breadth_first_search(@root, results, 0, block)
    results.flatten
  end

  def preorder
    results = []
    preorder_helper(@root, results)
    results
  end

  def inorder
    results = []
    inorder_helper(@root, results)
    results
  end

  def postorder
    results = []
    postorder_helper(@root, results)
    results
  end

  def height(node = @root)
    results = []
    breadth_first_search(node, results, 0)
    results.reduce(0) { |lim, array| [lim, array.length].max }
  end

  def depth(node)
    results = []
    breadth_first_search(@root, results, 0)
    results.length.times { |i| return i if results[i].include?(node.data) }
  end

  def balanced?(node = @root)
    return true if node.nil?

    diff = height(node.left) - height(node.right)
    (diff.abs <= 1) && balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    @root = build_tree(inorder)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
