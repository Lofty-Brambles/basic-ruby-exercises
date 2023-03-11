# frozen_string_literal: true

# mergsorting array
class MergeSort
  def initialize(array)
    @array = array
  end

  def sort(array = @array)
    return array if array.length < 2

    mid = array.length / 2
    left = sort(array[0...mid])
    right = sort(array[mid..array.length])
    sorter(left, right)
  end

  private

  def sorter(left, right)
    sorted = []
    sorted << (left.first <= right.first ? left.shift : right.shift) until left.empty? || right.empty?
    sorted + left + right
  end
end

test_array = [129, 476, 456, 955, 245, 939, 262, 607]
p MergeSort.new(test_array).sort
