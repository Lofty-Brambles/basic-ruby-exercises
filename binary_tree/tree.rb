# frozen_string_literal: true

# the main tree class
class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    
  end

  def insert(data, node = @root); end
  def delete(data); end
  def find(value, node = @root); end
  def level_order; end
  def preorder; end
  def inorder; end
  def postorder; end
  def height(node = @root); end
  def depth(node = @root); end
  def balanced?; end
  def rebalance; end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end