

def generate_anti_diagonals
  right = (-3..-1).map { |i| (-6..i).map { |j| [j.abs + i, j] } }
  left = (1..3).map { |i| (1..6 - i).map { |j| [i + j - 1, -j] } }
  right + left
end

p generate_anti_diagonals