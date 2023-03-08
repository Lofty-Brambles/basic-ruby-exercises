# frozen_string_literal: true

def swap_if_unordered(array, first, second)
  return unless array[first] > array[second]

  array[first], array[second] = array[second], array[first]
end

def bubble_sort(array)
  (array.length - 1).times do |i|
    (array.length - i - 1).times do |j|
      swap_if_unordered(array, j, j + 1)
    end
  end
  p array
end

bubble_sort([4, 3, 78, 2, 0, 2])
# => [0,2,2,3,4,78]
