# frozen_string_literal: true

# the integral component in the binary search tree
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(another)
    compared = another.instance_of(Node) ? another.data : another
    data <=> compared
  end
end
